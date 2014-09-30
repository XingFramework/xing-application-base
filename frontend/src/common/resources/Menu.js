import {BackendResource} from '../backend/BackendResource';

export class Menu extends BackendResource {
  emptyData(){
    return [];
  }

  backendResponds(promise){
    super(promise);

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
    super(response);
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

var itemPaths = {
  children: '$.data.children',
  internalTarget: '$.data.page.links.self',
  externalTarget: '$.data.url',
  type: '$.data.type',
  name: '$.data.name',
};

class MenuItem extends BackendResource {
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
    super(promise);
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

  hasChildren(){
    var children = this.pathGet(itemPaths.children);
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
      return this.pathGet(itemPaths.internalTarget);
    } else {
      return this.pathGet(itemPaths.externalTarget);
    }
  }
  set target(value){
    if(this.internal()){
      return this.pathSet(itemPaths.internalTarget, value);
    } else {
      return this.pathSet(itemPaths.externalTarget, value);
    }
  }

  get type(){
    return this.pathGet(itemPaths.type);
  }
  set type(value){
    var thumb, segment;
    if(MenuItem.types.indexOf(value) != -1){
      this.attic.types[this.type] = this.target;
      for(var path of [itemPaths.internalTarget, itemPaths.externalTarget]){
        this.pathClear(path);
      }
      this.pathSet(itemPaths.type, value);
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
        thumb["url"] = this.attic.types[this.type];
      }
    }
  }

  get name(){
    return this.pathGet(itemPaths.name);
  }
  set name(value){
    return this.pathSet(itemPaths.name, value);
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
