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
    return this.pageData.contents.styles.data.body;
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
    return this.pageData.contents.headline.data.body;
  }

  get contentBlocks() {
    var contents = this.pageData.contents;
    var blocks = [];
    for(var name in contents){
      if(contents.hasOwnProperty(name)){
        var content = contents[name];
        blocks.push({ name, content });
      }
    }
    return blocks;
  }

  get mainContent() {
    return this.pageData.contents.main.data.body;
  }

  get pageData() {
    return this._data;
  }
}
