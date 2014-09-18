import {ServerResponse} from './serverResponse';

class ContentBody {
  constructor(page, contentName) {
    this.page = page;
    this.contentName = contentName;
  }

  get content(){
    var pageData = this.page.pageData;
    if(!pageData || !pageData.contents){
      return "";
    }
    var block = pageData.contents[this.contentName];
    if(block && block["data"] && block["data"]["body"]){
      return block["data"]["body"];
    } else {
      return "";
    }
  }

  set content(value){
    var data = this.page.pageData;
    if(!(data.contents)){
      data.contents = {};
    }
    if(!(data.contents[this.contentName])){
      data.contents[this.contentName] = {};
    }
    var block = data.contents[this.contentName];
    if(!(block.data)){
      block.data = {};
    }
    block.data.body = value;
  }
}

var jsonPaths = {
  layout: "$.data.layout",
  title: "$.data.title",
  keywords: "$.data.keywords",
  description: "$.data.description",
  styles: "$.data.contents.styles.data.body",
  headline: "$.data.contents.headline.data.body",
  mainContent: "$.data.contents.main.data.body",
  publishStart: "$.data.publishStart",
  publishEnd: "$.data.publishEnd",
  urlSlug: "$.data.urlSlug",
};

export class Page extends ServerResponse {
  contentBody(name) {
    return new ContentBody(this, name);
  }

  get layout(){
    return this.pathGet(jsonPaths.layout);
  }
  set layout(value){
    return this.pathSet(jsonPaths.layout, value);
  }

  get title(){
    return this.pathGet(jsonPaths.title);
  }
  set title(value){
    return this.pathSet(jsonPaths.title, value);
  }

  get keywords(){
    return this.pathGet(jsonPaths.keywords);
  }
  set keywords(value){
    return this.pathSet(jsonPaths.keywords, value);
  }

  get description(){
    return this.pathGet(jsonPaths.description);
  }
  set description(value){
    return this.pathSet(jsonPaths.description, value);
  }

  get styles(){
    return this.pathGet(jsonPaths.styles);
  }
  set styles(value){
    return this.pathSet(jsonPaths.styles, value);
  }

  get headline(){
    return this.pathGet(jsonPaths.headline);
  }
  set headline(value){
    return this.pathSet(jsonPaths.headline, value);
  }

  get publishStart(){
    return this.pathGet(jsonPaths.publishStart);
  }
  set publishStart(value){
    return this.pathSet(jsonPaths.publishStart, value);
  }

  get publishEnd(){
    return this.pathGet(jsonPaths.publishEnd);
  }
  set publishEnd(value){
    return this.pathSet(jsonPaths.publishEnd, value);
  }

  get urlSlug(){
    return this.pathGet(jsonPaths.urlSlug);
  }
  set urlSlug(value){
    return this.pathSet(jsonPaths.urlSlug, value);
  }

  get mainContent() {
    return this.pathGet(jsonPaths.mainContent);
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

  get pageData() {
    return this._data;
  }
}
