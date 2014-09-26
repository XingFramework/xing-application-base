import {appName} from '../../common/config';
import {} from './adminModule';

angular.module( `${appName}.admin` )
.config(function config( $stateProvider ) {
  $stateProvider
    .state( 'root.admin', {
      url: 'admin/',
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
      resolve: {
        menuList(backend) {
          return backend.menuList().complete;
        }
      }
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
});
