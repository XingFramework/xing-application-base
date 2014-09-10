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
  paths: {
    'angular': './vendor/angular/angular'
  },
  shim: {
    'angular': {
      exports: 'angular'
    },
    "vendor/angular-mocks/angular-mocks": {
      deps: [ "angular" ]
    },
    "vendor/angular-ui-router/angular-ui-router": {
      deps: [ "angular" ]
    },
    "src/build/templates-app": {
      deps: [ "angular" ]
    },
    "src/build/templates-common": {
      deps: [ "angular" ]
    }
  },
  callback: window.__karma__.start
});
