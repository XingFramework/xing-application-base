import BackendResponse from './BackendResponse';

class Templates extends BackendResponse {
  absorbResponse(response) {
    super(response);
    this._uriTemplates = {};
    if (typeof this._links !== "undefined") {
      Object.keys(this._links).forEach((key) => {
        this._uriTemplates[key] = new UriTemplate(this._links[key]);
      });
    }
  }

  get uriTemplates() {
    return this._uriTemplates;
  }

  toJSON() {
    return this._response;
  }
}

var ResourceTemplates = {
  fetchedTemplates: null,
  get(backend) {
    if (this.fetchedTemplates) {
      return new Promise((resolve) => {
        return resolve(this.fetchedTemplates);
      });
    } else {
      var remoteResults = backend.load(Templates, "/resources");
      remoteResults = remoteResults.complete.then((completeResults) => {
        this.fetchedTemplates = completeResults.uriTemplates;
        window.localStorage.setItem("resourceTemplates", JSON.stringify(completeResults));
        return this.fetchedTemplates;
      });
      if (window.localStorage.getItem("resourceTemplates")) {
        var localResults = new Promise(function (resolve) {
          return resolve(JSON.parse(window.localStorage.getItem("resourceTemplates")));
        });
        localResults = new Templates(backend, localResults);
        return localResults.complete.then((completeResults) => {
          return completeResults.uriTemplates;
        });
      } else {
        return remoteResults;
      }
    }
  }
};

export default ResourceTemplates;
