// traceur dependencies
import {configuration} from '../../common/config';
import {} from '../../common/server/cms';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';

// angular dependencies
angular.module( `${configuration.appName}.pages`, [
  `${configuration.appName}.server`,
  'ui.router.state',
  'restangular'
])

.config(function config( $stateProvider ) {
  $stateProvider.state( 'cms.cmsBackend', {
    url: '/pages/:permalink',
    views: {
      "main": {
        controller: 'PagesCtrl',
        templateUrl: 'pages/pages.tpl.html'
      }
    }
  });
})

.controller( 'PagesCtrl', ['$scope', '$stateParams', 'cmsBackend', '$sce',
  function PagesController( $scope, $stateParams, cmsBackend, $sce ) {
    var thePage = cmsBackend.page($stateParams['permalink']);
    $scope.metadata = thePage.metadata;
    $scope.headline = thePage.headline;
    $scope.main = thePage.main;
    // TODO: set up metadata emit
    // var metadata = thePage.metadata;
    // $scope.$emit('metadataSet', metadata);
}]);
