import {ServerResponse} from './serverResponse';

export class Menu extends ServerResponse {
  constructor(promise){
    super(promise);
    this.completePromise = this.completePromise.then((result) => {
      var completes = this._items.map((item) => {
        return item.complete;
      });
      return Promise.all( completes);
    });
  }

  emptyData(){
    return [];
  }

  absorbResponse(response){
    super(response);
    if (typeof this._data === "undefined" || this._data.length === 0) {
      this._items = [];
    } else {
      this._items = this._data.map((item) => {
        var promise = new Promise((resolve) => { return resolve(item); });
        return new MenuItem(promise);
      });
    }
  }

  get items(){
    return this._items;
  }
}

class MenuItem extends ServerResponse {
  constructor(promise){
    super(promise);
    var childrenPromise = this.responsePromise.then((response) => {
      return { data: response["data"].children };
    });
    this.subMenu = new Menu(childrenPromise);
    this.completePromise = Promise.all([ this.completePromise, this.subMenu.completePromise ]);
  }

  hasChildren(){
    if(typeof this.children == "undefined"){
      return false;
    } else if(this.children.items.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  external(){
    return this.type == "raw_url";
  }

  internal(){
    return this.type == "page";
  }

  get type(){
    return this.menuData.type;
  }

  get target(){
    if(this.internal()){
      return this.menuData.page.links.self;
    } else {
      return this.menuData.url;
    }
  }

  get name(){
    return this.menuData.name;
  }

  get children(){
    return this.subMenu;
  }

  get menuData(){
    return this._data;
  }
}
