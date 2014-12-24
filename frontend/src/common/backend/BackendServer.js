export default class BackendServer {
  constructor(restangular){
    this.Restangular = restangular.withConfig(function(RestangularConfigurer) {
      RestangularConfigurer.setFullResponse(true);
    });
  }

  mangleUrl(url){
    return url.replace(/^\//,'');
  }

  // GET 200
  // GET xxx
  // PUT 200 Success - Modified: here's new representation
  // PUT 201 Created (we PUT a new resource, backend liked the URL)
  // PUT 204 No Content - yup, what you said
  // POST 201 Created - use Location to get new value
  // POST 303 See Other - yes, we have that already
  // With any luck, Restangular handles all these correctly. We're going to get
  // full backend response and unwrap it just in case, though --jdl
  save(resource){
    var url, backendReq, responds;
    var data = resource.dataForSave;
    if(!resource.isPersisted){
      url = this.mangleUrl(resource.postUrl);
      backendReq = this.Restangular.all(url);
      responds = backendReq.post(data);
    } else {
      url = this.mangleUrl(resource.putUrl);
      backendReq = this.Restangular.restangularizeElement(null, data, url);
      responds = backendReq.put();
    }
    resource.backendResponds(this.unwrap(responds));
  }

  remove(resource){ //because 'delete' is a keyword
    var url = this.mangleUrl(resource.deleteUrl);
    var backendReq = this.Restangular.restangularizeElement(null, resource._response, url);
    backendReq.remove();
  }

  load(ResourceClass, url = null, responseFn = null){
    var response = this.Restangular.one(this.mangleUrl(url)).get();
    if(responseFn){ response = responseFn(response); }
    return new ResourceClass(this, this.unwrap(response));
  }

  loadTo(url, resource){
    var response = this.Restangular.one(this.mangleUrl(url)).get();
    return resource.backendResponds(this.unwrap(response));
  }

  create(ResourceClass, postUrl){
    var resource =  new ResourceClass(this);
    resource.postUrl = postUrl;
    return resource;
  }

  unwrap(backendResponds){
    var backend = this;
    return backendResponds.then((fullResponse) => {
      if(fullResponse.status === 201 && fullResponse.headers().location){
        return backend.unwrap(backend.Restangular.oneUrl("response", fullResponse.headers().location).get());
      } else {
        return fullResponse.data;
      }
    });
  }
}
