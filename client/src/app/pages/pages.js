import {configuration} from '../../common/config';
import {} from '../../common/server/cms';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';
import './admin-edit';

angular.module( `${configuration.appName}.pages`, [
  `${configuration.appName}.server`,
  `${configuration.appName}.adminEditDirective`,
  'ui.router.state'
])

.config(function config( $stateProvider ) {
  $stateProvider
    .state( 'root.homepage', {
      url: 'home',
      controller: 'PagesCtrl',
      templateUrl: 'pages/homepage.tpl.html',
      resolve: {
        isAdmin($auth){
          return $auth.validateUser().then(
            (success) => {
            return true; },
            (failure) => {
              return false; }
          ).then((bool) => {
            return bool;
          });
        },
        page(cmsBackend) {
          return cmsBackend.page("/homepage").complete;
        }
      }
    })
    .state( 'root.inner.page', {
      url: '^/pages/*pageUrl',
      controller: 'PagesCtrl',
      abstract: true,
      template: "<ui-view></ui-view>",
      resolve: {
        isAdmin($auth){
          return $auth.validateUser().then(
            (success) => { return true; },
            (failure) => { return false; }
          ).then((bool) => { return bool; });
        },
        page(isAdmin, cmsBackend, $stateParams) {
          var role = "guest";
          if(isAdmin){ role = "admin"; }
          return cmsBackend.page($stateParams.pageUrl, role).complete.then( (page) => {
            return page;
          });
        }
      }
    })
    .state( 'root.inner.page.show', {
      url: '',
      templateUrl: 'pages/pages.tpl.html',
    })
    .state( 'root.inner.page.edit', {
      templateUrl: 'pages/page-edit.tpl.html',
      controller: 'PageEditCtrl',
      resolve: {
        onlyAdmin($auth){
          return $auth.validateUser();
        }
      }
    });
})
.controller( 'PageEditCtrl', function( $scope, $state, cmsBackend ){
  console.log("pages/pages.js:70", "$scope.nowEditing", $scope.nowEditing);
  $scope.nowEditing = true;
  $scope.cancelEdit = function(){
    $state.go("^.show");
  };
  $scope.savePage = function(){
    cmsBackend.save($scope.page);
    $state.go("^.show");
  };
  console.log("pages/pages.js:76", "$scope.nowEditing", $scope.nowEditing);
})
.controller( 'PagesCtrl', function( $scope, $state, $stateParams, $sce, page, isAdmin) {
  $scope.nowEditing = false;
  $scope.edit = function(){
    $state.go('^.edit');
  };

  $scope.froalaConfig = { };

  $scope.page = page;
  $scope.isAdmin = isAdmin;
  $scope.contentBlocks = {};
  $scope.template = 'pages/templates/' +page.layout + ".tpl.html";

  for(var name in page.contentBlocks) {
    if (page.contentBlocks.hasOwnProperty(name)) {
      $scope.contentBlocks[name] = $sce.trustAsHtml(page.contentBlocks[name]);
    }
  }
  // header info
  $scope.$emit('metadataSet', page.metadata);
});
