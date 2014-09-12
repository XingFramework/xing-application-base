import {Page} from './page';

export var OneColumnPage;

class OneColumnPage extends Page {

  get metadata(){
    return {
      title: this.pageData.title,
      keywords: this.pageData.keywords,
      description: this.pageData.description,
      styles: this.pageData.contents.styles.data.body
    };
  }

  get headline() {
    return this.pageData.contents.headline.data.body;
  }

  get main() {
    return this.pageData.contents.main.data.body;
  }

} 
