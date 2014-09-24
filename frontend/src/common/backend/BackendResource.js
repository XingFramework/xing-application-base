import jsonPath from '../jsonpath';

var paths = {
  selfUrl: "$.links.self"
};
export class BackendResource {
  constructor(backend, responsePromise) {
    this.backend = backend;

    this.errorReason = null;
    this.resolved = false;
    this._dirty = false;
    this._response = {
      "links": {},
      "data": this.emptyData()
    };
    this.responsePromise = null;
    this.completePromise = null;

    if(responsePromise){
      this.backendResponds(responsePromise);
    }
  }

  backendResponds(responsePromise){
    this.responsePromise = responsePromise;
    this.completePromise = responsePromise.then( (response) => {
      this.resolved = true;
      this._dirty = false;
      this.absorbResponse(response);
      return this;
    },
    (reason) => {
      console.log("Backend error:", this, reason);
      this.errorReason = reason;
      return this;
    });
  }

  loadFrom(url){
    if(typeof url === "undefined"){
      return;
    }

    if( url != this.selfUrl ){
      return this.backend.loadTo(url, this);
    }
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
    if(thumb[target] != value){
      this._dirty = true;
    }
    thumb[target] = value;
  }

  get isDirty(){
    return this._dirty;
  }

  get isNew(){
    return (this.responsePromise === null);
  }

  get selfUrl(){
    return this.pathGet(paths.selfUrl);
  }

  get putUrl(){
    return this.selfUrl;
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
