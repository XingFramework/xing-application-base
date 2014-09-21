import jsonPath from '../jsonpath';

// The more I think about it, this is a Server*Resource* not a response
export class ServerResponse {
  constructor(backend, responsePromise) {
    this.backend = backend;

    this.errorReason = null;
    this.resolved = false;
    this._response = {
      "links": {},
      "data": this.emptyData()
    };
    this.responsePromise = null;
    this.completePromise = null;

    if(responsePromise){
      this.serverResponds(responsePromise);
    }
  }

  serverResponds(responsePromise){
    this.responsePromise = responsePromise;
    this.completePromise = responsePromise.then( (response) => {
      this.resolved = true;
      this.absorbResponse(response);
      return this;
    },
    (reason) => {
      console.log("server/serverResponse.js:13", "reason", reason);
      this.errorReason = reason;
      return this;
    });
  }

  save(){
    return this.backend.save(this);
  }

  pathGet(path){
    return jsonPath(this._response, path, {flatten: true, wrap: false});
  }

  pathSet(jsonpath, value){
    var path = jsonPath(this._response, jsonpath, {wrap: false, resultType: "path"});
    var root = path.shift();
    var target = path.pop();
    var thumb = this._response;
    if(root !== "$"){
      console.log(`root of normalized path was '${root}', not '$'`);
    }
    for(var segment of path){
      thumb = thumb[segment];
    }
    thumb[target] = value;
  }

  get isNew(){
    return (this.responsePromise === null);
  }

  get putUrl(){
    return this._links["self"];
  }

  get received(){
    return this.responsePromise;
  }

  get complete(){
    return this.completePromise;
  }

  get dataForSave(){
    return this._response;
  }

  get _data(){
    return this._response["data"];
  }

  get _links(){
    return this._response["links"];
  }

  absorbResponse(response) {
    this._response = response;
  }

  emptyData(){
    return {};
  }
}
