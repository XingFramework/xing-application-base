import BackendResponse from './BackendResponse';
import ResourceTemplates from './ResourceTemplates';

export class BackendResource extends BackendResponse {
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

  defineRelatedShortLink(ResourceClass, shortLinkName, propertyName) {
    Object.defineProperty(this, shortLinkName, {
      enumerable: true,
      configurable: true,
      get: function() {
        if (this._uriTemplates && this.resourceName) {
          var params = this._uriTemplates[ResourceClass.prototype.resourceName].fromUri(this[propertyName]);
          return ResourceClass.prototype.shortLinkFromParams(params);
        } else {
          return null;
        }
      }
    });
  }

  get shortLink() {
    if (this._uriTemplates && this.resourceName && this.selfUrl) {
      var params = this._uriTemplates[this.resourceName].fromUri(this.selfUrl);
      return this.shortLinkFromParams(params);
    } else {
      return null;
    }
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