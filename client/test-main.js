tests = [];
for (var file in window.__karma__.files) {
  if (window.__karma__.files.hasOwnProperty(file)) {
    if (/test\/.*\.js$/.test(file) && !/test\/json-fixtures/.test(file)) {
      tests.push(file);
    }
  }
}
tests = tests.map(function(file){
  return file.replace(/^\/base\/|\.js$/g,'');
})

requirejs.config({
  baseUrl: '/base/',
  deps: tests,
  shim: {
    "vendor/angular-mocks/angular-mocks": {
      deps: [ "vendor/angular/angular" ]
    },
    "vendor/angular-ui-router/release/angular-ui-router": {
      deps: [ "vendor/angular/angular" ]
    },
    "src/build/templates-app": {
      deps: [ "vendor/angular/angular" ]
    },
    "src/build/templates-common": {
      deps: [ "vendor/angular/angular" ]
    }
  },
  callback: window.__karma__.start
});
