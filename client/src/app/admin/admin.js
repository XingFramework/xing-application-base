import {configuration} from '../../common/config';
import {} from '../../common/server/cms';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';
import {} from "./directives";

console.log("admin/admin.js:6");
angular.module( `${configuration.appName}.admin`, [
  `${configuration.appName}.server`,
  `${configuration.appName}.adminDirectives`,
  'ui.router.state'
])

.config(function config( $stateProvider ) {
  $stateProvider
    .state( 'root.admin', {
      url: 'admin',
      templateUrl: 'admin/admin.tpl.html',
   })
    .state( 'root.admin.pages', {
      url: 'pages',
      controller: 'AdminPagesCtrl',
      templateUrl: 'admin/pages.tpl.html',
      //resolve: {
        //page(cmsBackend) {
          //return cmsBackend.page("/homepage").complete;
        //}
      //}
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
.controller( 'AdminPagesCtrl', function( $scope, $stateParams, $sce) {
  console.log("admin/admin.js:34", "admin", page);
  // header info
})
.controller( 'AdminMenusCtrl', function( $scope, $stateParams, $sce) {

})
.controller( 'AdminDocumentsCtrl', function( $scope, $stateParams, $sce) {

})
.controller( 'AdminImagesCtrl', function( $scope, $stateParams, $sce) {

});
