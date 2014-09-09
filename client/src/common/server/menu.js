export var Menu;

class Menu {
  constructor(responsePromise) {
    this.response = null;
    this.errorReason = null;
    this.resolved = false;
    responsePromise.then( (response) => {
      this.resolved = true;
      this.response = response;
    },
    (reason) => {
      this.resolved = true;
      this.errorReason = reason;
    })
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

  get type(){
    return this.menuData.type;
  }

  get target(){
    return this.menuData.url;
  }

  get name(){
    return this.menuData.name;
  }

  get children(){
    if(this.resolved){
      return this.menuData.children.map((item) => {
        return new Menu(new Promise((resolve) => { return resolve(item); }));
      });
    } else {
      return [];
    }
  }

  get menuData(){
    if(this.resolved){
      console.log("server/menu.js:60", "this.response", this.response);
      return this.response["data"];
    } else {
      return {};
    }
  }
}
