export var Page;

class Page {
  constructor(response) {
    this.response = response;
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

  get main(){
    return this.pageData.contents.main.data.body;
  }

  get headline(){
    return this.pageData.contents.headline.data.body;
  }

  get resolvedResponse(){
    var resolved;
    this.response.then(
      (response) => { resolved = response; },
      (reason) => { throw "There was an error: " + reason.toString(); }
    );

    return resolved;
  }

  get pageData(){
    return resolvedResponse["data"];
  }

}