import {} from '../../vendor/angular/angular';
import {} from '../../vendor/angular-ui-router/angular-ui-router';
import {} from '../build/templates-app';
import {} from '../build/templates-common';
import {} from './navigationBar/navigationBar';
import {} from '../common/server/cms';
import {configuration} from '../common/config';
import "../common/ui-route-logger";

angular.module( configuration.appName, [
  'templates-app', 'templates-common', 'ui.router',
  `${configuration.appName}.server`, `${configuration.appName}.navigationBar`,
  `${configuration.appName}.route-logger`
  `${configuration.appName}.pages`
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
        return menu;
      }
    }
  });
  $stateProvider.state('cms.static', {
    url: "",
    templateUrl: "cms-static.tpl.html",
  });
})
.controller( 'CmsCtrl', function CmsCtrl( $scope, $location, mainMenu, $state ) {
  $scope.mainMenu = mainMenu;
  console.log("app/cms.js:36", "$state.href('cms.page', {pageUrl: 'test'})", $state.href('cms.page', {pageUrl: 'test'}));
});
