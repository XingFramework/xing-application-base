import {} from '../../vendor/angular/angular';
import {} from '../../vendor/angular-ui-router/angular-ui-router';
import {} from '../build/templates-app';
import {} from '../build/templates-common';
import {configuration} from '../common/config';

angular.module( configuration.appName, [
  'templates-app',
  'templates-common',
  //'client-app.home',
  'ui.router'
])
.config( function myAppConfig( $stateProvider, $urlRouterProvider ) {
  $urlRouterProvider.otherwise( '/' );
  $stateProvider.state('cms', {
    url: "/",
    templateUrl: "app/cms.tpl.html",
    controller: 'CmsCtrl'
  });
})
.run( function run() { })
.controller( 'CmsCtrl', function AppCtrl( $scope, $location ) {
  $scope.$on('$stateChangeSuccess', function(event, toState, toParams, fromState, fromParams){
    if ( angular.isDefined( toState.data.pageTitle ) ) {
      $scope.pageTitle = toState.data.pageTitle + ' | ' + configuration.appTitle;
    }
  });
});
