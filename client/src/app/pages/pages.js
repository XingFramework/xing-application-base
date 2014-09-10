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

    var page = cmsBackend.page($stateParams['permalink']);
    page.responsePromise.then( (resolve) =>
      {
        // page content
        console.log("page",page);
        var metadata = page.metadata;
        $scope.headline = page.headline;
        $scope.content = $sce.trustAsHtml(page.mainContent);

        // header info
        var things = metadata.pageStyles;
        console.log("before",things);
        var styles = $sce.trustAs('css', things);
        console.log("after",styles);
        console.log(metadata.pageStyles);
        $scope.$emit('metadataSet', metadata);
      }
    );
}]);
