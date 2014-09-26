import {appName} from '../../common/config';
import slugify from '../../common/slugify';
import {} from './menusModule';

angular.module(`${appName}.menus`)
.controller( 'MenusCtrl', function( $scope, $state, $stateParams, $sce, menu, isAdmin) {
  $scope.menuActions = {
    edit(){
      $state.go('^.edit', {}, {location: false});
    },
    /*
    show(){
      $state.go("^.show", {menuUrl: menu.slugUrl});
    },
    */
    save(){
      menu.save();
      menu.complete.then((menu) => {
        $state.go("^.^.menus");
        return menu;
      });
    }
  };

  $scope.menu = menu;
  $scope.isAdmin = isAdmin;

})
.controller( 'MenusNewCtrl', ( $scope ) => {
  $scope.edit();
})
.controller( 'MenusEditCtrl', ( $scope ) => {
  $scope.edit();
});
