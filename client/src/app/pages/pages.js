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
      abstract: true,
      url: '/pages/:permalink',
      controller: 'PagesCtrl',
      templateUrl: 'pages/page.tpl.html'
    })
    .state( 'cms.cmsBackend.one_column', {
      url: '',
      templateUrl: 'pages/template/one_column.tpl.html'
    })
    .state( 'cms.cmsBackend.two_column', {
      url: '',
      templateUrl: 'pages/template/two_column.tpl.html'
    });
})
.controller( 'PagesCtrl', ['$scope', '$stateParams', 'cmsBackend', '$sce', '$state',
  function PagesController( $scope, $stateParams, cmsBackend, $sce, $state) {
    $scope.headline = {};
    $scope.content = {};
    $scope.metadata = {};
    $scope.templateData = {};

    var page = cmsBackend.page($stateParams['permalink']);
    page.then( (resolve) =>
      {
        // page content
        $scope.headline = page.headline;
        $scope.content = $sce.trustAsHtml(page.mainContent);

        // header info
        $scope.metadata = page.metadata; // scoped for testing
        $scope.template = page.template; // scoped for testing
        $scope.$emit('metadataSet', page.metadata);
        $scope.$emit('templateSet', page.template);

        // go to state for template
        $state.transitionTo(`cms.cmsBackend.${page.template.name}`);
      }
    );
}]);
