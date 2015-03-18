import BackendResource from 'framework/backend/BackendResource.js';

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

export class Page extends BackendResource {
  constructor(backend, promise){
    super(backend, promise);
    this.setupContents();
    this._role = "guest";
    this._layoutKinds = [];
    for(var layoutName in layouts){
      if(layouts.hasOwnProperty(layoutName)){
        this._layoutKinds.push({"name": layouts[layoutName]["label"], "value": layoutName});
      }
    }
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

  backendResponds(promise){
    super.backendResponds(promise);
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

  get slugUrl(){
    return this.publicUrl || this.selfUrl;
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
    return this._layoutKinds;
  }

  setupContents(){
    var blockName;
    var contents = this.pathGet(this.jsonPaths.contents);
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
    return this.pathGet(this.jsonPaths.layout);
  }

  set layout(value){
    var ret = this.pathSet(this.jsonPaths.layout, value);
    this.setupContents();
    return ret;
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
    var contents = this.pathGet(this.jsonPaths.contents);
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

  get resourceName() {
    return "page";
  }

  // this should be overridden
  shortLinkFromParams(params) {
    return params["url_slug"];
  }

  // this should be overridden
  paramsFromShortLink(shortLink) {
    return {url_slug: shortLink};
  }

  get shortLink() {
    return this.shortLinkFromUrl(this.slugUrl);
  }

}

Page.prototype.defineJsonProperty("layout", "$.data.layout");
Page.prototype.defineJsonProperty("title", "$.data.title");
Page.prototype.defineJsonProperty("keywords", "$.data.keywords");
Page.prototype.defineJsonProperty("description", "$.data.description");
Page.prototype.defineJsonProperty("contents", '$.data.contents');
Page.prototype.defineJsonProperty("styles", "$.data.contents.styles.data.body");
Page.prototype.defineJsonProperty("headline", "$.data.contents.headline.data.body");
Page.prototype.defineJsonProperty("mainContent", "$.data.contents.main.data.body");
Page.prototype.defineJsonProperty("publishStart", "$.data.publishStart");
Page.prototype.defineJsonProperty("publishEnd", "$.data.publishEnd");
Page.prototype.defineJsonProperty("urlSlug", "$.data.urlSlug");

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
