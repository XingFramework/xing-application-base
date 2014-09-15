import {ServerResponse} from './serverResponse';

export class PageList extends ServerResponse {
  get pages(){
    return this._data.map((item) => { return new PageItem(item); });
  }
}

class PageItem {
  constructor(itemData){
    this._data = itemData;
  }

  get title(){
    return this._data["data"]["title"];
  }

  get target(){
    return this._data["links"]["public"];
  }
}
