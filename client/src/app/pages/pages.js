import {configuration} from '../../common/config';
import {} from '../../common/server/cms';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';

angular.module( `${configuration.appName}.pages`, [
  `${configuration.appName}.server`,
  'ui.router.state'
])

.config(function config( $stateProvider ) {
  $stateProvider
    .state( 'cms.homepage', {
      url: 'home',
      controller: 'PagesCtrl',
      templateUrl: 'pages/homepage.tpl.html',
      resolve: {
        page(cmsBackend) {
          return cmsBackend.page("/homepage").complete;
        }
      }
    })
    .state( 'cms.page', {
      url: 'pages/:pageUrl',
      controller: 'PagesCtrl',
      templateUrl: 'pages/pages.tpl.html',
      resolve: {
        page(cmsBackend, $stateParams) {
          console.log("pages/pages.js:29", "$stateParams", $stateParams);
          return cmsBackend.page($stateParams.pageUrl).complete;
        }
      }
    });
})
.controller( 'PagesCtrl', function( $scope, $stateParams, $sce, page) {
  console.log("pages/pages.js:25", "page", page);
  $scope.contentBlocks = {};
  $scope.headline = page.headline;
  $scope.template = 'pages/templates/' +page.layout + ".tpl.html";
  for(var name in page.contentBlocks) {
    if (page.contentBlocks.hasOwnProperty(name)) {
      $scope.contentBlocks[name] = $sce.trustAsHtml(page.contentBlocks[name]);
    }
  }
  // header info
  $scope.$emit('metadataSet', page.metadata);
});
