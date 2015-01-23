import {BackendResource} from '../backend/BackendResource';

export default class MenuList extends BackendResource {
  constructor(backend, url){
    super(backend,url);
    this.menus = [];
  }

  emptyData(){
    return [];
  }

  absorbResponse(data){
    super.absorbResponse(data);

    var length = data["data"].length;
    for(var index = 0; index < length; index++){
      this.menus.push(new Item(this, index));
    }
  }

  urlForName(name){
    var menu = this.menus.find((item) => {
      return item.name == name;
    });
    if(menu) {
      return menu.url;
    } else {
      return undefined;
    }
  }
}

class Item {
  constructor(list, item){
    this._list = list;
    this._item = item;
  }

  get name(){
    return this._list.pathGet(`$.data[${this._item}].data.name`);
  }

  get url(){
    return this._list.pathGet(`$.data[${this._item}].links.self`);
  }
}
