import {ServerResponse} from './serverResponse';

var jsonPaths = {
  publicUrl: "$.links.public",
  adminUrl: "$.links.admin",
  layout: "$.data.layout",
  title: "$.data.title",
  keywords: "$.data.keywords",
  description: "$.data.description",
  contents: '$.data.contents',
  styles: "$.data.contents.styles.data.body",
  headline: "$.data.contents.headline.data.body",
  mainContent: "$.data.contents.main.data.body",
  publishStart: "$.data.publishStart",
  publishEnd: "$.data.publishEnd",
  urlSlug: "$.data.urlSlug",
};

var layouts = {
  "one_column": {
    "label": "One Column",
    "template": {
      "main": { type: "text/html" },
    }
  },
  "two_column": {
    "label": "Two Column",
    "template": {
      "columnOne": { type: "text/html" },
      "columnTwo": { type: "text/html" }
    }
  }
};

export class Page extends ServerResponse {
  constructor(backend, promise){
    super(backend, promise);
    this._role = "guest";
  }

  emptyData(){
    return {
      "layout": "one_column",
      "title": "",
      "keywords": "",
      "description": "",
      "contents": {
        "styles": this.emptyContent("text/css"),
        "headline": this.emptyContent("text/html")
      },
      "publishStart": null,
      "publishEnd": null,
      "urlSlug": ""
    };
  }

  emptyContent(type){
    return {
      "links": {},
      "data": {
        "contentType": type,
        "body": ""
      }
    };
  }

  serverResponds(promise){
    super(promise);
    this.completePromise = this.completePromise.then((page) => {
      if(page.role === "admin" && page.adminUrl){
        page.loadFrom(page.adminUrl); //XXX Whole new load flow - other complete.thens unpredictable
      }
      return page;
    });
  }

  loadFrom(url){
    if(typeof url === "undefined"){
      return;
    }

    if((url != this.selfUrl || (this.role === "admin" && url != this.publicUrl) )){
      return this.backend.loadTo(url, this);
    }
  }

  get publicUrl(){
    return this.pathGet(jsonPaths.publicUrl);
  }
  get adminUrl(){
    return this.pathGet(jsonPaths.adminUrl);
  }

  get role(){
    return this._role;
  }
  set role(value){
    if(this._role !== value){
      this._dirty = true;
    }
    this._role = value;
  }

  get layoutKinds(){
    var kindList = [];
    for(var layoutName in layouts){
      if(layouts.hasOwnProperty(layoutName)){
        kindList.push([layouts[layoutName]["label"], layoutName]);
      }
    }
    return kindList;
  }

  setupContents(){
    var blockName;
    var contents = this.pathGet(jsonPaths.contents);
    var templateLayout = layouts[this.layout]["template"];
    if(templateLayout){

      var layoutNames = Object.getOwnPropertyNames(templateLayout);
      layoutNames.push("headline", "styles");
      for(blockName of layoutNames) {
        if(!contents.hasOwnProperty(blockName)){
          contents[blockName] = this.emptyContent(templateLayout.type);
        }
      }
      for(blockName of Object.getOwnPropertyNames(contents)) {
        if("headline" !== blockName && "styles" !== blockName && !templateLayout.hasOwnProperty(blockName)){
          delete contents[blockName];
        }
      }
    }
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

  contentBody(name) {
    return new ContentBody(this, name);
  }

  get contentBlocks() {
    var contentBlocks = {};
    var contents = this.pathGet(jsonPaths.contents);
    for (var name in contents) {
      if (contents.hasOwnProperty(name)) {
        //contentBlocks[name] = this.pageData.contents[name].data.body;
        contentBlocks[name] = this.contentBody(name).content;
      }
    }
    return contentBlocks;
  }

  get pageData() {
    return this._data;
  }
}

class ContentBody {
  constructor(page, contentName) {
    this.page = page;
    this.contentName = contentName;
    this.path = `$.data.contents.${contentName}.data.body`;
  }

  get content(){
    var body = this.page.pathGet(this.path);
    if(body){
      return body;
    } else {
      return "";
    }
  }

  set content(value){
    return this.page.pathSet(this.path, value);
  }
}
