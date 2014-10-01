requireJsConfig = {
  baseUrl: '/base/',
  paths: {
    'angular': './vendor/angular/angular',
    'jquery': './vendor/jquery/jquery'
  },
  shim: {
    'angular': {
      exports: 'angular'
    },
    "vendor/FroalaWysiwygEditor/froala_editor.min": {
      deps: [ "jquery" ]
    },
    "vendor/angular-fontawesome/angular-fontawesome": {
      deps: [ "angular" ]
    },
    "vendor/angular-cookies/angular-cookies": {
      deps: [ "angular" ]
    },
    "vendor/ng-token-auth/ng-token-auth": {
      deps: [ "angular" ]
    },
    "vendor/angular-mocks/angular-mocks": {
      deps: [ "angular" ]
    },
    "vendor/restangular/restangular": {
      deps: [ "angular" ]
    },
    "vendor/angular-ui-router/angular-ui-router": {
      deps: [ "angular" ]
    },
    "build/templates-app": {
      deps: [ "angular" ]
    },
    "build/templates-common": {
      deps: [ "angular" ]
    }

  },
  callback: window.__karma__.start
};

tests = [];
for (var file in window.__karma__.files) {
  if (window.__karma__.files.hasOwnProperty(file)) {
    if (/test\/.*\.js$/.test(file)) {
      if (!/test\/json-fixtures/.test(file)) {
        tests.push(file);
      } else {
        requireJsConfig.shim[file.replace(/^\/base\/|\.js$/g,'')] = { deps: ["angular"] };
      }
    }
  }
}
requireJsConfig.deps = tests.map(function(file){
  return file.replace(/^\/base\/|\.js$/g,'');
})

requirejs.config(requireJsConfig);
