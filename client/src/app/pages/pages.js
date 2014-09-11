import {configuration} from '../../common/config';
import {} from '../../common/server/cms';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';

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
    $scope.headline = {};
    $scope.content = {};
    $scope.metadata = {};

    var page = cmsBackend.page($stateParams['permalink']);
    page.then( (resolve) =>
      {
        // page content
        $scope.metadata = page.metadata;
        $scope.headline = page.headline;
        $scope.content = $sce.trustAsHtml(page.mainContent);

        // header info
        $scope.$emit('metadataSet', $scope.metadata);
      }
    );
}]);
