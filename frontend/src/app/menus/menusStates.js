import {appName} from '../../common/config';
import {} from './menusModule';

angular.module(`${appName}.menus`)
.config(function config( $stateProvider ) {
  $stateProvider
    .state( 'root.admin.menu', {
      url: '^/menus/',
      controller: 'MenusCtrl',
      abstract: true,
      template: "<ui-view lrd-state-attrs></ui-view>",
      resolve: {
        isAdmin($auth){
          return $auth.validateUser().then(
            (success) => { return true; },
            (failure) => { return false; }
          ).then((bool) => { return bool; });
        },
        menu(backend) { return backend.createMenu(); },
        pageList(backend) { return backend.pageList().complete; }
      }
    })
    .state( 'root.admin.menu.new', {
      url: 'new',
      controller: 'MenuNewCtrl',
      //templateUrl: 'menus/menu-create.tpl.html',
      resolve: { onlyAdmin($auth){ return $auth.validateUser(); } },
    })
    .state( 'root.admin.menu.show', {
      url: '*menuUrl',
      controller: 'MenuShowCtrl',
      resolve: {
        menuLoaded(isAdmin, menu, $stateParams){
          if(isAdmin){
            menu.role = "admin";
          } else {
            menu.role = "guest";
          }
          menu.loadFrom($stateParams.menuUrl);
          return menu.complete.catch((error) => {
            throw error;
          });
        }
      },
      //templateUrl: 'menus/menus.tpl.html',
    })
    .state( 'root.admin.menu.edit', {
      templateUrl: 'menus/edit.tpl.html',
      controller: 'MenuEditCtrl',
      resolve: { onlyAdmin($auth){ return $auth.validateUser(); } }
    });
});
