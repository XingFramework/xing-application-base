import BackendResponse from './BackendResponse.js';
import ResourceTemplates from './ResourceTemplates.js';

export default class BackendResource extends BackendResponse {
  constructor(backend, responsePromise) {
    super(backend, responsePromise);
    this._uriTemplates = null;
    this.uriPromise = ResourceTemplates.get(this.backend).then((uriTemplates) => {
      this._uriTemplates = uriTemplates;
      return this;
    });
  }

  // this should be overridden
  get resourceName() {
    return "";
  }

  // this should be overridden
  shortLinkFromParams(params) {
    return params[Object.keys(params)[0]];
  }

  // this should be overridden
  paramsFromShortLink(shortLink) {
    return {};
  }

  urlFromShortLink(shortLink) {
    if (this._uriTemplates && this.resourceName) {
      var params = this.paramsFromShortLink(shortLink);
      return this._uriTemplates[this.resourceName].fillFromObject(params);
    } else {
      return null;
    }
  }

  shortLinkFromUrl(url) {
    if (this._uriTemplates && this.resourceName && url) {
      var params = this._uriTemplates[this.resourceName].fromUri(url);
      return this.shortLinkFromParams(params);
    } else {
      return null;
    }
  }

  defineRelatedShortLink(ResourceClass, shortLinkName, propertyName) {
    Object.defineProperty(this, shortLinkName, {
      enumerable: true,
      configurable: true,
      get: function() {
        if (this._uriTemplates && ResourceClass.prototype.resourceName) {
          var params = this._uriTemplates[ResourceClass.prototype.resourceName].fromUri(this[propertyName]);
          return ResourceClass.prototype.shortLinkFromParams(params);
        } else {
          return null;
        }
      }
    });
  }

  get shortLink() {
    return this.shortLinkFromUrl(this.selfUrl);
  }

  get complete() {
    return this.uriPromise.then((resource) => {
      return this.completePromise;
    });
  }

  loadFromShortLink(shortLink) {
    this.uriPromise = ResourceTemplates.get(this.backend).then((uriTemplates) => {
      this._uriTemplates = uriTemplates;
      var url = this.urlFromShortLink(shortLink);
      this.loadFrom(url);
      return this;
    });
    return this.uriPromise;
  }

}
