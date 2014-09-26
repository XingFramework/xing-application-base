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

  get items(){
    return this._items;
  }
}

class MenuItem extends BackendResource {
  backendResponds(promise){
    super(promise);
    var childrenPromise = this.responsePromise.then((response) => {
      return { data: response["data"]["children"] };
    });
    this.subMenu = new Menu(this.backend, childrenPromise);
    this.completePromise = Promise.all([ this.completePromise, this.subMenu.completePromise ]).then((responses) => { return this; });
  }

  get jsonPaths() {
    return {
      children: '$.data.children',
      internalTarget: '$.data.page.links.self',
      externalTarget: '$.data.url',
      type: '$.data.type',
      name: '$.data.name',
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

  get children(){
    return this.subMenu;
  }

  get menuData(){
    return this._data;
  }
}
