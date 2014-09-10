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

  get title(){
    return this.pageData.title;
  }

  get keywords(){
    return this.pageData.keywords;
  }

  get description(){
    return this.pageData.description;
  }

  get styles(){
    return this.pageData.contents.styles.data.body;
  }

  get metadata(){
    return {
      layout: this.layout,
      title: this.title,
      keywords: this.keywords,
      description: this.description,
      styles: this.styles
    };
  }

  get headline() {
    return this.pageData.contents.headline.data.body;
  }

  get mainContent() {
    return this.pageData.contents.main.data.body;
  }

  get pageData() {
    return this._pageData;
  }
}