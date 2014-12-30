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
      return new Promise((globalResolve) => {
        if (!this.remotePromise) {
          var remoteResults = backend.load(Templates, "/resources");
          this.remotePromise = remoteResults.complete.then((completeResults) => {
            this.fetchedTemplates = completeResults.uriTemplates;
            window.localStorage.setItem("resourceTemplates", JSON.stringify(completeResults));
            return this.fetchedTemplates;
          });
        }
        if (window.localStorage.getItem("resourceTemplates")) {
          var localResults = new Promise(function (localResolve) {
            return localResolve(JSON.parse(window.localStorage.getItem("resourceTemplates")));
          });
          localResults = new Templates(backend, localResults);
          localResults.complete.then((completeResults) => {
            globalResolve(completeResults.uriTemplates);
          });
        } else {
          this.remotePromise = this.remotePromise.then(function(fetchedTemplates) {
            globalResolve(fetchedTemplates);
            return fetchedTemplates;
          });
        }
      });

    }
  }
};

export default ResourceTemplates;
