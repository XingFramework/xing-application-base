
function mangleUrl(url){
  return url.replace(/^\//,'');
}

export default class BackendServer {
  constructor(restangular){
    this.Restangular = restangular.withConfig(function(RestangularConfigurer) {
      RestangularConfigurer.setFullResponse(true);
    });
  }


  // GET 200
  // GET xxx
  // PUT 200 Success - Modified: here's new representation
  // PUT 201 Created (we PUT a new resource, server liked the URL)
  // PUT 204 No Content - yup, what you said
  // POST 201 Created - use Location to get new value
  // POST 303 See Other - yes, we have that already
  // With any luck, Restangular handles all these correctly. We're going to get
  // full server response and unwrap it just in case, though --jdl
  save(resource){
    var url, serverReq, responds;
    var data = resource.dataForSave;
    if(resource.isNew){
      url = mangleUrl(resource.postUrl);
      serverReq = this.Restangular.restangularizeCollection(null, {}, url);
      responds = serverReq.post(data);
    } else {
      url = mangleUrl(resource.putUrl);
      serverReq = this.Restangular.restangularizeElement(null, data, url);
      responds = serverReq.put();
    }
    resource.serverResponds(this.unwrap(responds));
  }

  load(ResourceClass, url, responseFn){
    var response = this.Restangular.one(mangleUrl(url)).get();
    if(responseFn){ response = responseFn(response); }
    return new ResourceClass(this, this.unwrap(response));
  }

  loadTo(url, resource){
    var response = this.Restangular.one(mangleUrl(url)).get();
    return resource.serverResponds(this.unwrap(response));
  }

  create(ResourceClass, postUrl){
    var resource =  new ResourceClass(this);
    resource.postUrl = postUrl;
    return resource;
  }

  unwrap(serverResponds){
    return serverResponds.then((fullResponse) => {
      return fullResponse.data;
    });
  }

}
