import {configuration} from '../../common/config';
import {} from '../../common/server/backend';
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
      controller: 'PagesCtrl',
      template: "<ui-view></ui-view>",
      abstract: true,
      url: 'home',
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
        page(isAdmin, backend) {
          var role = "guest";
          if(isAdmin){ role = "admin"; }
          return backend.page("/homepage", role).complete;
        }
      }
    })
    .state( 'root.homepage.show', {
      url: '',
      templateUrl: 'pages/homepage.tpl.html',
    })
    .state( 'root.homepage.edit', {
      templateUrl: 'pages/homepage-edit.tpl.html',
      controller: 'PageEditCtrl',
      resolve: {
        onlyAdmin($auth){
          return $auth.validateUser();
        }
      }
    })
    .state( 'root.inner.page', {
      url: '^/pages/',
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
        page(backend) {
          console.log("pages/pages.js:47", "new page");
          return backend.createPage(); }
      }
    })
    .state( 'root.inner.page.show', {
      url: '*pageUrl',
      resolve: {
        pageLoaded(isAdmin, page, $stateParams){
          if(isAdmin){
            page.role = "admin";
          } else {
            page.role = "guest";
          }
          page.loadFrom($stateParams.pageUrl);
          return page.complete;
        }
      },
      templateUrl: 'pages/pages.tpl.html',
    })
    .state( 'root.inner.page.edit', {
      templateUrl: 'pages/page-edit.tpl.html',
      controller: 'PageEditCtrl',
      resolve: {
        onlyAdmin($auth){ return $auth.validateUser(); }
        }
    })
    .state( 'root.inner.page.new', {
      url: 'new',
      resolve: {
        onlyAdmin($auth){ return $auth.validateUser(); }
      },
      controller: 'PageNewCtrl'
    });
})
.controller( 'PageNewCtrl', function( $state ){
  $state.go("^.edit");
})
.controller( 'PageEditCtrl', function( $scope, $state, page ){
  // I think there's potential for improving UX here: duplicate the existing page, edit that -
  // on save, submit that and discard the old page. On cancel, swap it back in.
  // Let admin switch back and forth until they decide "this is good" and save
  //    --jdl
  $scope.nowEditing = true;
  $scope.cancelEdit = function(){
    $state.go("^.show");
  };
  $scope.savePage = function(){
    page.save();
    page.complete.then((page) => {
    $state.go("^.show");
      return page;
    });
  };
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
