export class ServerResponse {
  constructor(responsePromise) {
    this.response = null;
    this.errorReason = null;
    this.resolved = false;
    this._data = this.emptyData();
    this.responsePromise = responsePromise;
    this.completePromise = responsePromise.then( (response) => {
      this.absorbResponse(response);
      return response;
    },
    (reason) => {
      this.errorReason = reason;
      return reason;
    });
  }

  get received(){
    return this.responsePromise;
  }

  get complete(){
    return this.completePromise;
  }

  absorbResponse(response) {
    this._data = response["data"];
  }

  emptyData(){
    return {};
  }
}
