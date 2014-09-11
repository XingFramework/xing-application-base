import {} from '../../vendor/angular/angular';
import {} from '../../vendor/angular-ui-router/angular-ui-router';
import {} from '../build/templates-app';
import {} from '../build/templates-common';
import {} from './navigationBar/navigationBar';
import {} from '../common/server/cms';
import {configuration} from '../common/config';

angular.module( configuration.appName, [
  'templates-app', 'templates-common', 'ui.router',
  `${configuration.appName}.server`, `${configuration.appName}.navigationBar`
])
.config( function myAppConfig( $stateProvider, $urlRouterProvider ) {
  $urlRouterProvider.otherwise( '/' );
  $stateProvider.state('cms', {
    templateUrl: "cms.tpl.html",
    controller: 'CmsCtrl',
    abstract: true,
    url: "/",
    resolve: {
      mainMenu(cmsBackend){
        var menu = cmsBackend.menu("main");
        console.log("app/cms.js:25", "menu", menu);
        return menu;
      }
    }
  });
  $stateProvider.state('cms.static', {
    url: "",
    controller: 'CmsStaticCtrl',
    templateUrl: "cms-static.tpl.html",
  });
})
.run( function ( $rootScope ) {
  $rootScope.$on('$stateChangeStart', (event, toState) => {
    console.log("app/cms.js:15", "event", event);
    console.log("app/cms.js:16", "toState", toState);
  });
  $rootScope.$on('$stateNotFound', (event, missingState) => {
    console.log("app/cms.js:19", "event", event);
    console.log("app/cms.js:20", "missingState", missingState);
  });
  $rootScope.$on('$stateChangeSuccess', (event, toState) => {
    console.log("app/cms.js:24", "event", event);
    console.log("app/cms.js:24", "toState", toState);
  });
  $rootScope.$on('$stateChangeError', (event, toState, toParams, fromState, fromParams, error) => {
    console.log("app/cms.js:49", "event", event);
    console.log("app/cms.js:49", "toState", toState);
    console.log("app/cms.js:50", "error", error);
    console.log("app/cms.js:51", "error.stack", error.stack);
  });
})
.controller( 'CmsCtrl', function CmsCtrl( $scope, $location, mainMenu ) {
  console.log("app/cms.js:55", "mainMenu", mainMenu);
  $scope.mainMenu = mainMenu;
})
.controller( 'CmsStaticCtrl', function CmsStaticCtrl($scope) {
  console.log("app/cms.js:36", "staticControler", $scope);
});
