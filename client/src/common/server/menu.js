import {ServerResponse} from './serverResponse.js';

class MenuItem extends ServerResponse {
  constructor(promise){
    super(promise);
    var childrenPromise = this.responsePromise.then((response) => {
      return response["data"].children;
    });
    this._children = new Menu(childrenPromise);
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
    return this.menuData.url;
  }

  get name(){
    return this.menuData.name;
  }

  get children(){
    return this._children;
  }

  get menuData(){
    if(this.resolved){
      return this.response["data"];
    } else {
      return {};
    }
  }
}

export class Menu extends ServerResponse {
  constructor(promise){
    super(promise);
    this.responsePromise = this.responsePromise.then((response) => {
      this._items = response["data"].map((item) => {
        var promise = new Promise((resolve) => { return resolve(item); });
        return new MenuItem(promise);
      });
      return response;
    });
    this._items = [];
  }
  get items(){
    return this._items;
  }
}
