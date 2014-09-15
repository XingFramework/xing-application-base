import {ServerResponse} from './serverResponse';

export class Page extends ServerResponse {
  get layout(){
    return this.pageData.layout;
  }
  set layout(value){
    this.pageData.layout = value;
  }

  get title(){
    return this.pageData.title;
  }
  set title(value){
    this.pageData.title = value;
  }

  get keywords(){
    return this.pageData.keywords;
  }
  set keywords(value){
    this.pageData.keywords = value;
  }

  get description(){
    return this.pageData.description;
  }
  set description(value){
    this.pageData.description = value;
  }

  get styles(){
    if (typeof(this.pageData.contents.styles) != 'undefined') {
      return this.pageData.contents.styles.data.body;
    } else {
      return null;
    }
  }
  set styles(value){
    if (typeof(this.pageData.contents.styles) != 'undefined') {
      this.pageData.contents.styles = { data: {}};
    }
    this.pageData.contents.styles.data.body = value;
  }

  get headline() {
    if(typeof this.pageData.contents.headline === "undefined") {
      return null;
    } else {
      return this.pageData.contents.headline.data.body;
    }
  }
  set headline(value){
    if (typeof(this.pageData.contents.headline) != 'undefined') {
      this.pageData.contents.headline = { data: {}};
    }
    this.pageData.contents.headline.data.body = value;
  }

  get publishStart(){
    return this.pageData.publishStart;
  }
  set publishStart(value){
    this.pageData.publishStart = value;
  }

  get publishEnd(){
    return this.pageData.publishEnd;
  }
  set publishEnd(value){
    this.pageData.publishEnd = value;
  }

  get urlSlug(){
    return this.pageData.urlSlug;
  }
  set urlSlug(value){
    this.pageData.urlSlug = value;
  }


  get metadata(){
    return {
      pageTitle: this.title,
      pageKeywords: this.keywords,
      pageDescription: this.description,
      pageStyles: this.styles
    };
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
