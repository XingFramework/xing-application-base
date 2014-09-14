import {ServerResponse} from './serverResponse';

export class Page extends ServerResponse {
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
    if (typeof(this.pageData.contents.styles) != 'undefined') {
      return this.pageData.contents.styles.data.body;
    } else {
      return null;
    }
  }

  get metadata(){
    return {
      pageTitle: this.title,
      pageKeywords: this.keywords,
      pageDescription: this.description,
      pageStyles: this.styles
    };
  }

  get headline() {
    if(typeof this.pageData.contents.headline === "undefined") {
      return null;
    } else {
      return this.pageData.contents.headline.data.body;
    }
  }

  get contentBlocks() {
    var contentBlocks = {};
    for (var name in this.pageData.contents) {
      if (this.pageData.contents.hasOwnProperty(name)) {
        contentBlocks[name] = this.pageData.contents[name].data.body;
      }
    }
    return contentBlocks;
  }

  get mainContent() {
    return this.pageData.contents.main.data.body;
  }

  get pageData() {
    return this._data;
  }
}
