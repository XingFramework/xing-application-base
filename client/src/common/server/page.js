import {ServerResponse} from './serverResponse';

export var Page;

class Page extends ServerResponse {
  constructor(promise) {
    super(promise);
    this._pageData = {};
    this.responsePromise = this.responsePromise.then(
      (response) => {
        this._pageData = response["data"];
        return response;
      },
      (reason) => {throw "There was an error: " + reason.toString();});
  }

  get layout(){
    return this.pageData.layout;
  }

  get metadata(){
    return {
      title: this.pageData.title,
      keywords: this.pageData.keywords,
      description: this.pageData.description,
    };
  }

  get pageData() {
    return this._pageData;
  }
}
