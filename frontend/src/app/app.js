import {} from '../../vendor/jquery/jquery';
import {appName} from '../common/config';
import {} from '../../vendor/angular/angular';
import {} from '../../vendor/angular-fontawesome/angular-fontawesome';
import {} from '../../vendor/angular-ui-router/angular-ui-router';
import {} from '../../build/templates-app';
import {} from '../../build/templates-common';
import {} from './navigationBar/navigationBar';
import {} from '../common/backend/backend';
import {} from "../common/ui-route-logger";
import {} from './admin/admin';
import {} from './auth/auth';
import {} from './pages/pages';
import {} from './menus/menus';
import {} from './homepage/homepage';
import {} from './metadata/metadata';
import {} from './responsiveMenu/responsiveMenu';

angular.module( appName, [
  'templates-app', 'templates-common', 'ui.router',
  'picardy.fontawesome',
  `${appName}.backend`, `${appName}.navigationBar`,
  `${appName}.route-logger`,
  `${appName}.pages`,
  `${appName}.menus`,
  `${appName}.homepage`,
  `${appName}.auth`,
  `${appName}.admin`,
  `${appName}.responsiveMenu`,
  `${appName}.metadata`
])
.config( function myAppConfig( $stateProvider, $urlRouterProvider ) {
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
        return menu.complete;
      }
    }
  }).state('root.inner', {
    templateUrl: "inner.tpl.html",
    abstract: true,
    url: "inner"
  });
})
.controller( 'RootCtrl', function RootCtrl( $scope, $location, menuRoot, $state ) {
  $scope.mainMenu = menuRoot.children;
  $scope.$watch(
    ()=>{ return menuRoot.etag; },
    ()=>{
      console.log("app/app.js:58", "menuRoot.etag", menuRoot.etag);
      $scope.mainMenu = menuRoot.children;
    });
});
