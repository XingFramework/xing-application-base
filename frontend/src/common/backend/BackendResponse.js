import jsonPath from '../jsonpath';

var paths = {
  publicUrl: "$.links.public",
  adminUrl: "$.links.admin",
  selfUrl: "$.links.self"
};

export default class BackendResponse {
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

  defineJsonProperty(name, path) {
    if (!(this.hasOwnProperty("jsonPaths"))) {
      this.jsonPaths = Object.create(this.jsonPaths || {});
    }
    this.jsonPaths[name] = path;
    if (!(this.hasOwnProperty(name))) {
      Object.defineProperty(this, name, {
        enumerable: true,
        configurable: true,
        get: function() {
          return this.pathGet(path);
        },
        set: function(value) {
          return this.pathSet(path, value);
        }
      });
    }
  }

  backendResponds(responsePromise){
    this.responsePromise = responsePromise;
    this.completePromise = this.responsePromise.then(
      (response) => {
        this.resolved = true;
        this._dirty = false;
        this.absorbResponse(response);
        return this;
      },
      (reason) => {
        console.log("Backend error:", this, reason);
        this.errorReason = reason;
        throw this;
      }
    );
  }

  loadFrom(url){
    if(typeof url === "undefined"){
      return;
    }

    if( url != this.selfUrl ){
      return this.backend.loadTo(url, this);
    }
  }

  reload(){
    return this.backend.loadTo(this.selfUrl, this);
  }

  save(){
    return this.backend.save(this);
  }

  remove(){
    return this.backend.remove(this);
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
      console.log(`root of normalized path '${path}' was '${root}', not '$'`);
    }
    for(var segment of path){
      thumb = thumb[segment];
    }
    if(thumb[target] != value){
      this._dirty = true;
    }
    thumb[target] = value;
  }

  pathClear(jsonpath){
    var path = jsonPath(this._response, jsonpath, {wrap: false, resultType: "path"});
    if(!path){ return; }
    var root = path.shift();
    var target = path.pop();
    var thumb = this._response;
    if(root !== "$"){
      console.log(`root of normalized path was '${root}', not '$'`);
    }
    for(var segment of path){
      thumb = thumb[segment];
    }
    delete thumb[target];
  }

  get isDirty(){
    return this._dirty;
  }

  get isNew(){
    return (this.responsePromise === null);
  }

  get publicUrl(){
    return this.pathGet(paths.publicUrl);
  }

  get adminUrl(){
    return this.pathGet(paths.adminUrl);
  }

  get selfUrl(){
    return this.pathGet(paths.selfUrl);
  }

  get putUrl(){
    return this.selfUrl;
  }
  get deleteUrl(){
    return this.putUrl;
  }

  get etag(){
    return this._response.restangularEtag;
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
