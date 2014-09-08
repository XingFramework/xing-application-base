export var Menu;

class Menu {
  constructor(response) {
    this.response = response;
  }

  hasChildren(){
    if(typeof this.children == "undefined"){
      return false;
    } else if(this.children.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  external(){
    return this.menuData.type == "raw_url";
  }

  internal(){
    return this.menuData.type == "page";
  }

  get target(){
    return this.menuData.url;
  }

  get name(){
    return this.menuData.name;
  }

  get children(){
    return this.menuData.children.map((item) => {
      return new Menu(new Promise((resolve) => { return resolve(item) });
    });
  }

  get resolvedResponse(){
    var resolved;
    this.response.then(
      (response) => { resolved = response; },
      (reason) => { throw "There was an error: " + reason.toString(); }
    );

    return resolved;
  }

  get menuData(){
    return resolvedResponse["data"];
  }
}
