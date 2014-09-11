import {configuration} from '../../common/config';
import {} from '../../common/server/cms';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';

angular.module( `${configuration.appName}.pages`, [
  `${configuration.appName}.server`,
  'ui.router.state',
  'restangular'
])

.config(function config( $stateProvider ) {
  $stateProvider
    .state( 'cms.cmsBackend', {
      url: '/pages/:permalink',
      controller: 'PagesCtrl',
      templateUrl: 'pages/page.tpl.html'
    });
})
.controller( 'PagesCtrl', ['$scope', '$stateParams', 'cmsBackend', '$sce',
  function PagesController( $scope, $stateParams, cmsBackend, $sce) {
    $scope.headline = {};
    $scope.content = {};
    $scope.metadata = {};

    var page = cmsBackend.page($stateParams['permalink']);
    page.complete.then( (resolve) =>
      {
        // page content
        $scope.headline = page.headline;
        $scope.content = $sce.trustAsHtml(page.mainContent);

        // header info
        $scope.metadata = page.metadata; // scoped for testing
        $scope.template = page.template; // scoped for testing
        $scope.$emit('metadataSet', page.metadata);
        $scope.$emit('templateSet', page.template);
      }
    );
}]);
