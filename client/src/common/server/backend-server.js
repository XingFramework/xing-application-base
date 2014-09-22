import {Menu} from './menu';
import {Page} from './page';
import {PageList} from './pageList';

function mangleUrl(url){
  return url.replace(/^\//,'');
}

export default class CMSBackendServer {
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

  loadTo(resource, url){
    var response = this.Restangular.one(mangleUrl(url)).get();
    return resource.serverResponds(response);
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

  pageList(){
    return this.load(PageList, '/admin/pages');
  }

  menu(name){
    return this.load(Menu, `/navigation/${name}`);
  }

  homepage(){
    return this.load(Homepage, '/homepage');
  }

  page(slug, forRole){
    if(forRole !== "admin"){
      return this.load(Page, slug);
    } else {
      return this.load(Page, slug, (response) => {
        var publicData;
        return response.then((serverData) => {
          publicData = serverData;
          var newUrl = mangleUrl(serverData.data.links.admin);
          return this.Restangular.one(newUrl).get();
        }).catch((failure) => {
          //assuming unauthorized
          return publicData;
        });
      });
    }
  }

  createPage(){
    return create(Page, '/admin/pages');
  }
}
