import {appName} from '../../common/config';
import {} from '../../common/backend/backend';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';
import {} from "./directives";

angular.module( `${appName}.admin`, [
  `${appName}.backend`,
  `${appName}.adminDirectives`,
  'ui.router.state'
])

.config(function config( $stateProvider ) {
  $stateProvider
    .state( 'root.admin', {
      url: 'admin',
      templateUrl: 'admin/admin.tpl.html',
      resolve: {
        isAdmin($auth){
          return $auth.validateUser();
        }
      }
   })
    .state( 'root.admin.pages', {
      url: 'pages',
      controller: 'AdminPagesCtrl',
      templateUrl: 'admin/pages.tpl.html',
      resolve: {
        pageList(backend) {
          return backend.pageList().complete;
        }
      }
    })
    .state( 'root.admin.menus', {
      url: 'menus',
      controller: 'AdminMenusCtrl',
      templateUrl: 'admin/menus.tpl.html',
    })
    .state( 'root.admin.documents', {
      url: 'documents',
      controller: 'AdminDocumentsCtrl',
      templateUrl: 'admin/documents.tpl.html',
    })
    .state( 'root.admin.images', {
      url: 'images',
      controller: 'AdminImagesCtrl',
      templateUrl: 'admin/images.tpl.html',
    });
})
.controller( 'AdminPagesCtrl', function( $scope, $stateParams, $sce, pageList) {
  $scope.pageList = pageList;
  $scope.pages = pageList.pages;
  $scope.newPage = function(){
    backend.createPage();
  };
  // header info
})
.controller( 'AdminMenusCtrl', function( $scope, $stateParams, $sce) {

})
.controller( 'AdminDocumentsCtrl', function( $scope, $stateParams, $sce) {

})
.controller( 'AdminImagesCtrl', function( $scope, $stateParams, $sce) {

});
