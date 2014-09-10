export class ServerResponse {
  constructor(responsePromise) {
    this.response = null;
    this.errorReason = null;
    this.resolved = false;
    this.responsePromise = responsePromise.then( (response) => {
      this.resolved = true;
      this.response = response;
      return response;
    },
    (reason) => {
      this.resolved = true;
      this.errorReason = reason;
      return reason;
    });
  }
}

