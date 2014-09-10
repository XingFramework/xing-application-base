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
    templateUrl: "app/cms.tpl.html",
    controller: 'CmsCtrl',
    resolve: {
      mainMenu(cmsBackend){ return cmsBackend.menu("main"); }
    }
  });
  $stateProvider.state('cms.static', {
    url: "/",
    controller: 'CmsStaticCtrl',
    templateUrl: "app/cms-static.tpl.html",
  });
})
.controller( 'CmsCtrl', function CmsCtrl( $scope, $location, mainMenu ) {
  $scope.mainMenu = mainMenu;
})
.controller( 'CmsStaticCtrl', function CmsStaticCtrl($scope) {
});
