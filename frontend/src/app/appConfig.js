import {Config} from 'a1atscript';
import {State, Resolve} from 'stateInjector';

export function whenGoto($location) {
  var search = $location.search();
  if (search.goto) {
    var target = search.goto;

    var queryParts = [];
    for(var key in search){
      if(search.hasOwnProperty(key) && key != "goto"){
        queryParts.push([key, search[key]].join("="));
      }
    }

    if(queryParts.length > 0){
      target = [target, queryParts.join("&")].join("?");
    }

    return target;
  } else {
    return false;
  }
}

@Config('$stateProvider', '$urlRouterProvider', '$locationProvider')
export function appConfig( $stateProvider, $urlRouterProvider, $locationProvider ) {
  // enable html5 mode
  $locationProvider.html5Mode(true);

  // html5 mode when frontend urls hit directly they become a backend request
  // backend in-turn redirects to /?goto=url wher url is the intended frontend url
  // this function then redirects frontend (via history API) to appropriate frontend
  // route
  $urlRouterProvider.when(/.*/, ['$location', whenGoto]);

  $urlRouterProvider.otherwise(($injector, $location) => {
    $injector.get('$state').go('root.homepage.show');
    //return '/home';
  });
}

@State('root')
export class RootState {
  constructor() {
    this.templateUrl = "root.tpl.html";
    this.controller = 'RootCtrl';
    this.abstract = true;
    this.url = "/";
  }

  @Resolve('backend')
  menuRoot(backend) {
    return backend.menu("Main Menu");
  }
}

@State('root.inner')
export class RootInnerState {
  constructor() {
    this.templateUrl ="inner.tpl.html";
    this.abstract = true;
    this.url = "inner";
  }
}
