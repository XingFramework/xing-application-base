import {configuration} from '../../common/config';
import {} from '../../common/server/cms';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';

angular.module( `${configuration.appName}.pages`, [
  'ui.router.state',
  'restangular'
])

.config(function config( $stateProvider ) {
  $stateProvider.state( 'cms.pages', {
    url: '/pages/:permalink',
    views: {
      "main": {
        controller: 'PagesCtrl',
        templateUrl: 'pages/pages.tpl.html'
      }
    },
    data:{ pageTitle: 'Awesome' }
  });
})

.factory('Pages', ['Restangular', function PagesService(Restangular) {
  return Restangular.service('pages');
}])

.controller( 'PagesCtrl', ['$scope', '$stateParams', 'Pages', '$sce',
  function PagesController( $scope, $stateParams, Pages, $sce ) {
    $scope.content = {};
    Pages.one($stateParams.permalink).get().then(function(page) {
      $scope.content = $sce.trustAsHtml(page.content);
      $scope.headline = page.headline;
      var metadata = {};
      metadata.pageTitle = page.title;
      metadata.pageKeywords = page.keywords;
      metadata.pageDescription = page.description;
      metadata.pageCss = page.css;
      $scope.$emit('metadataSet', metadata);
    });
}]);
