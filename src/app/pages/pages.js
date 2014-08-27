angular.module( 'LRNewWebsite.pages', [
  'ui.router.state',
  'restangular'
])

.config(function config( $stateProvider ) {
  $stateProvider.state( 'pages', {
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

.controller( 'PagesCtrl', ['$scope', '$stateParams', 'Pages',
  function PagesController( $scope, $stateParams, Pages ) {
    $scope.content = {};
    Pages.one($stateParams.permalink).get().then(function(page) {
      $scope.content = page.content;
      var metadata = {};
      metadata.pageTitle = page.title;
      metadata.pageKeywords = page.keywords;
      metadata.pageDescription = page.description;
      metadata.pageCss = page.css;
      $scope.$emit('metadataSet', metadata);
    });
}]);

