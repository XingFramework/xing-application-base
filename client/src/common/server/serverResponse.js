export class ServerResponse {
  constructor(responsePromise) {
    this.response = null;
    this.errorReason = null;
    this.resolved = false;
    this._data = this.emptyData();
    this.responsePromise = responsePromise;
    this.completePromise = responsePromise.then( (response) => {
      this.absorbResponse(response);
      return this;
    },
    (reason) => {
      console.log("server/serverResponse.js:13", "reason", reason);
      this.errorReason = reason;
      return reason;
    });
  }

  get isNew(){
    return false;
  }

  get putUrl(){
    return this._links["self"];
  }

  get received(){
    return this.responsePromise;
  }

  get complete(){
    return this.completePromise;
  }

  get dataForSave(){
    return this._response;
  }

  absorbResponse(response) {
    this._response = response;
    this._data = response["data"];
    this._links = response["links"];
  }

  emptyData(){
    return {};
  }
}
