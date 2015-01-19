import {BackendResource} from '../backend/BackendResource';
import {Page} from "./Page";

export class Menu extends BackendResource {
  emptyData(){
    return [];
  }

  backendResponds(promise){
    super.backendResponds(promise);
    this.completePromise = this.completePromise.then((result) => {
      var completes = this._items.map((item) => {
        return item.complete;
      });
      return Promise.all(completes);
    }).then((responses) => {
      return this;
    });
  }

  absorbResponse(response){
    super.absorbResponse(response);
    if (typeof this._data === "undefined" || this._data.length === 0) {
      this._items = [];
    } else {
      this._items = this._data.map((item) => {
        var promise = new Promise((resolve) => { return resolve(item); });
        return new MenuItem(this.backend, promise);
      });
    }
  }

  syncItems(){
    this._response["data"].splice(0, this._response["data"].length);
    for( var item of this.items ){
      this._response["data"].push(item._response);
    }
  }

  get items(){
    return this._items;
  }
}

export class MenuItem extends BackendResource {
  constructor(backend,promise){
    super(backend,promise);
    this.attic = {
      types: {
        "raw_url": "",
        "page": ""
      }
    };
  }
  backendResponds(promise){
    super.backendResponds(promise);
    var childrenPromise = this.responsePromise.then((response) => {
      if(!response["data"]){
        response["data"] = {};
      }
      if(!response["data"]["children"]){
        response["data"]["children"] = [];
      }
      return { data: response["data"]["children"] };
    });
    this.subMenu = new Menu(this.backend, childrenPromise);
    this.completePromise = Promise.all([ this.completePromise, this.subMenu.completePromise ]).then((responses) => { return this; });
  }

  emptyData(){
    return {
      "name": "",
      "type": "raw_url",
      "path": "",
      "children": []
    };
  }
  hasChildren(){
    var children = this.pathGet(this.jsonPaths.children);
    return (children && children.length > 0);
  }

  external(){
    return this.type == "raw_url";
  }

  internal(){
    return this.type == "page";
  }

  get target(){
    if(this.internal()){
      return this.pathGet(this.jsonPaths.internalTarget);
    } else {
      return this.pathGet(this.jsonPaths.externalTarget);
    }
  }
  set target(value){
    if(this.internal()){
      return this.pathSet(this.jsonPaths.internalTarget, value);
    } else {
      return this.pathSet(this.jsonPaths.externalTarget, value);
    }
  }
  get type(){
    return this.pathGet(this.jsonPaths.type);
  }
  set type(value){
    var thumb, segment;
    if(MenuItem.types.indexOf(value) != -1){
      this.attic.types[this.type] = this.target;
      for(var path of [this.jsonPaths.internalTarget, this.jsonPaths.externalTarget]){
        this.pathClear(path);
      }
      this.pathSet(this.jsonPaths.type, value);
      if(this.internal()){
        thumb = this._response;
        for(segment of ["data", "page", "links" ]){
          if(!thumb[segment]){
            thumb[segment] = {};
          }
          thumb = thumb[segment];
        }
        thumb["self"] = this.attic.types[this.type];
      } else {
        thumb = this._response;
        for(segment of ["data" ]){
          if(!thumb[segment]){
            thumb[segment] = {};
          }
          thumb = thumb[segment];
        }
        thumb["path"] = this.attic.types[this.type];
      }
    }
  }

  get name(){
    return this.pathGet(this.jsonPaths.name);
  }
  set name(value){
    return this.pathSet(this.jsonPaths.name, value);
  }

  get children(){
    return this.subMenu;
  }

  get menuData(){
    return this._data;
  }

  get typeOptions(){
    return MenuItem.typeOptions;
  }
}
MenuItem.typeOptions = [
  { name: "External URL", type: "raw_url" },
  { name: "Content Page", type: "page" },
];
MenuItem.types = [for (option of MenuItem.typeOptions) option.type];

MenuItem.prototype.defineJsonProperty("children", '$.data.children');
MenuItem.prototype.defineJsonProperty("internalTarget", '$.data.page.links.self');
MenuItem.prototype.defineJsonProperty("externalTarget", '$.data.path');
MenuItem.prototype.defineJsonProperty("type", '$.data.type');
MenuItem.prototype.defineJsonProperty("name", '$.data.name');
MenuItem.prototype.defineRelatedShortLink(Page, "pageTarget", "internalTarget");
