import {appName} from '../../common/config';
import slugify from '../../common/slugify';
import {} from './menusModule';

angular.module(`${appName}.menus`)
.controller( 'MenusCtrl', function( $scope, $state, $stateParams, menu, isAdmin, pageList) {
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

  $scope.editing = {
    toggle(editScope){ editScope.toggle(); },
    hasChildren(editScope){
      return editScope.$modelValue.hasChildren();
    },
    select(editScope){
      $scope.selectedItem = editScope.$modelValue;
    },
    remove(editScope){
      console.log("menus/menusControllers.js:35", "remove editScope", editScope);
    },
    newSubItem(editScope){
      console.log("menus/menusControllers.js:38", "new sub editScope", editScope);
    }
  };
  $scope.menu = menu;
  $scope.pages = pageList.pages;
  $scope.treeOptions = {
    dropped(event){
      var sourceMenu, destMenu, sourceScope, destScope;
      sourceScope = event.source.nodesScope.$nodeScope;
      destScope = event.dest.nodesScope.$nodeScope;

      sourceMenu = sourceScope === null ? menu.children : sourceScope.$modelValue.children;
      destMenu = destScope === null ? menu.children : destScope.$modelValue.children;

      sourceMenu.syncItems();
      if(sourceMenu != destMenu){
        destMenu.syncItems();
      }

    }
  };
  $scope.isAdmin = isAdmin;
  $scope.menuName = "A menu";

  $scope.selectedItem = null;
})
.controller( 'MenuNewCtrl', ( $scope ) => {
  $scope.menuActions.edit();
})
.controller( 'MenuShowCtrl', ( $scope ) => {
  $scope.menuActions.edit();
})
.controller( 'MenuEditCtrl', ( $scope ) => {
});
