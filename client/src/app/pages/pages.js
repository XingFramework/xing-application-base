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
      resolve: {
        page(cmsBackend, $stateParams){
          return cmsBackend.page($stateParams['permalink']);
        }
      },
      templateUrl: 'pages/page.tpl.html'
    })
    .state( 'cms.page.layout', {
      url: '',
      templateUrl($scope){
        return $scope.page.layoutUrl;
      }
    });

})
.controller( 'PagesCtrl', function( $scope, $state, $sce, page) {
    $scope.headline = {};
    $scope.content = {};
    $scope.metadata = {};

    console.log("pages/pages.js:36", "page", page);
    page.complete.then( (resolve) =>
      {
        // page content
        $scope.headline = page.headline;
        $scope.content = {};
        console.log("pages/pages.js:41", "page.contentBlocks", page.contentBlocks);
        for(var block of page.contentBlocks){
          $scope.content[block.name] = $sce.trustAsHtml(block.content);
        }

        // header info
        $scope.metadata = page.metadata; // scoped for testing
        $scope.template = page.template; // scoped for testing
        $scope.$emit('metadataSet', page.metadata);
        $scope.$emit('templateSet', page.template);

        $state.go('layout');
      }
    );
});
