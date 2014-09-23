import {ServerResponse} from '../server/ServerResponse';

export class Menu extends ServerResponse {
  emptyData(){
    return [];
  }

  serverResponds(promise){
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

var itemPaths = {
  children: '$.data.children',
  internalTarget: '$.data.page.links.self',
  externalTarget: '$.data.url',
  type: '$.data.type',
  name: '$.data.name',
};

class MenuItem extends ServerResponse {
  serverResponds(promise){
    super(promise);
    var childrenPromise = this.responsePromise.then((response) => {
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

  get type(){
    return this.pathGet(itemPaths.type);
  }

  get name(){
    return this.pathGet(itemPaths.name);
  }

  get children(){
    return this.subMenu;
  }

  get menuData(){
    return this._data;
  }
}