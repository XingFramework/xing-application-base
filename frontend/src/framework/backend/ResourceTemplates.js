import BackendResponse from './BackendResponse.js';

class Templates extends BackendResponse {
  absorbResponse(response) {
    super.absorbResponse(response);
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
    if (!this.fetchedTemplates) {
      var remoteResults = backend.load(Templates, "/resources");
      this.fetchedTemplates = remoteResults.complete.then((completeResults) => {
          return completeResults.uriTemplates;
      });
    }
    return this.fetchedTemplates;
  }
};

export default ResourceTemplates;
