import {} from '../../vendor/angular/angular';
import {} from '../../vendor/angular-ui-router/angular-ui-router';
import {} from '../../build/templates-app';
import {} from '../../build/templates-common';
import {} from './navigationBar/navigationBar';
import {} from '../common/server/backend';
import {configuration} from '../common/config';
import "../common/ui-route-logger";
import '../../vendor/responsive-nav/responsive-nav';
import {} from './admin/admin';
import {} from './auth/auth';

angular.module( configuration.appName, [
  'templates-app', 'templates-common', 'ui.router',
  `${configuration.appName}.server`, `${configuration.appName}.navigationBar`,
  `${configuration.appName}.route-logger`,
  `${configuration.appName}.pages`,
  `${configuration.appName}.auth`,
  `${configuration.appName}.admin`
])
.config( function myAppConfig( $stateProvider, $urlRouterProvider ) {
  $urlRouterProvider.otherwise(($injector, $location) => {
    console.log("app/cms.js:18", "$location", $location);
    return '/home';
  });
  $stateProvider.state('root', {
    templateUrl: "root.tpl.html",
    controller: 'RootCtrl',
    abstract: true,
    url: "/",
    resolve: {
      mainMenu(backend){
        var menu = backend.menu("main");
        return menu;
      }
    }
  }).state('root.inner', {
    templateUrl: "innerpage.tpl.html",
    abstract: true,
    url: "inner"
  });
})
.controller( 'RootCtrl', function RootCtrl( $scope, $location, mainMenu, $state ) {
  $scope.mainMenu = mainMenu;
})
.controller( 'MetadataCtrl', function MetadataCtrl($scope, $rootScope) {
  var loadMetadata = function (metadata) {
    if ( angular.isDefined( metadata.pageTitle ) ) {
      $scope.pageTitle = metadata.pageTitle + ' | Logical Reality' ;
    }
    if ( angular.isDefined( metadata.pageKeywords ) ) {
      $scope.pageKeywords = metadata.pageKeywords;
    }
    if ( angular.isDefined( metadata.pageDescription ) ) {
      $scope.pageDescription = metadata.pageDescription;
    }
    if ( angular.isDefined( metadata.pageCss ) ) {
      $scope.pageCss = metadata.pageCss ;
    }
  };

  $rootScope.$on('metadataSet', function(event, metadata) {
    loadMetadata(metadata);
  });
})

.controller( 'HomepageCtrl', function HomepageCtrl($scope, backend) {

  $scope.metadata = {};

  var page = backend.page($stateParams['permalink']);
  page.responsePromise.then( (resolve) =>
    {
      $scope.metadata = page.metadata;
      //$scope.metadata.styles = $sce.css(page.metadata.styles);
      $scope.$emit('metadataSet', $scope.metadata);
    }
  );
});
