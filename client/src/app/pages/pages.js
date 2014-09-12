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
    .state( 'cms.page', {
      url: 'pages/:pageUrl',
      controller: 'PagesCtrl',
      templateUrl: 'pages/pages.tpl.html',
      resolve: {
        page(cmsBackend, $stateParams) {
          return cmsBackend.page($stateParams.pageUrl);
        }
      }
    });
})
.controller( 'PagesCtrl', function( $scope, $stateParams, $sce, page) {
    $scope.headline = {};
    $scope.content = {};
    $scope.metadata = {};
    $scope.template = "";

    page.complete.then( (page) =>
      {
        // page content
        $scope.headline = page.headline;
        $scope.template = 'pages/templates/' +page.layout + ".tpl.html";
        $scope.content = {};
        for(var block of page.contentBlocks){
          $scope.content[block.name] = $sce.trustAsHtml(block.content);
        }
        // header info
        $scope.metadata = page.metadata; // scoped for testing
        $scope.template = page.template; // scoped for testing
        $scope.$emit('metadataSet', page.metadata);
      }
    );
});
