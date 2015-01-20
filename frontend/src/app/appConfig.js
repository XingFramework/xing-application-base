import {Config} from 'a1atscript';

@Config(['$stateProvider', '$urlRouterProvider', '$locationProvider' ])
export default function appConfig( $stateProvider, $urlRouterProvider, $locationProvider ) {
  // enable html5 mode
  $locationProvider.html5Mode(true);

  // html5 mode when frontend urls hit directly they become a backend request
  // backend in-turn redirects to /?goto=url wher url is the intended frontend url
  // this function then redirects frontend (via history API) to appropriate frontend
  // route
  $urlRouterProvider.when("/?goto", ['$match', function ($match) {
    if ($match.goto) {
      return $match.goto;
    } else {
      return false;
    }
  }]);

  $urlRouterProvider.otherwise(($injector, $location) => {
    return '/home';
  });
  $stateProvider.state('root', {
    templateUrl: "root.tpl.html",
    controller: 'RootCtrl',
    abstract: true,
    url: "/",
    resolve: {
      menuRoot(backend) {
        var menu = backend.menu("main");
        return menu.complete.then(
          (menu) => menu,
          (nothing) => nothing
        );
      }
    }
  }).state('root.inner', {
    templateUrl: "inner.tpl.html",
    abstract: true,
    url: "inner"
  });
}
