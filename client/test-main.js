tests = [];
fixtureShims = {};
for (var file in window.__karma__.files) {
  if (window.__karma__.files.hasOwnProperty(file)) {
    if (/test\/.*\.js$/.test(file)) {
      if (!/test\/json-fixtures/.test(file)) {
        tests.push(file);
      } else {
        fixtureShims[file.replace(/^\/base\/|\.js$/g,'')] = { deps: ["angular"] };
      }
    }
  }
}
tests = tests.map(function(file){
  return file.replace(/^\/base\/|\.js$/g,'');
})

function extend(target) {
    var sources = [].slice.call(arguments, 1);
    sources.forEach(function (source) {
        for (var prop in source) {
            target[prop] = source[prop];
        }
    });
    return target;
}

requirejs.config({
  baseUrl: '/base/',
  deps: tests,
  paths: {
    'angular': './vendor/angular/angular'
  },
  shim: extend({}, fixtureShims, {
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

  }),
  callback: window.__karma__.start
});
