import BackendResource from 'framework/backend/BackendResource.js';
import {Page} from './Page.js';

export class PageList extends BackendResource {
  get pages(){
    return this._data.map((item) => { return new PageItem(item, this._uriTemplates["page"]); });
  }
}

class PageItem {
  constructor(itemData, uriTemplate){
    this._data = itemData;
    this._uriTemplate = uriTemplate;
  }

  get title(){
    return this._data["data"]["title"];
  }

  get target(){
    return this._data["links"]["public"];
  }

  get shortLink() {
    return Page.prototype.shortLinkFromParams(this._uriTemplate.fromUri(this.target));
  }
}
