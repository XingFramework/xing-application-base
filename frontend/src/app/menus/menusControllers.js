import slugify from '../../common/slugify';
import {Controller} from 'a1atscript';

@Controller('MenusCtrl', ['$scope', '$state', '$stateParams', 'menu', 'isAdmin', 'pageList', 'backend', 'menuRoot'])
export function MenusController( $scope, $state, $stateParams, menu, isAdmin, pageList, backend, menuRoot) {
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
        menuRoot.reload();
        return menu;
      });
    }
  };

  function syncScope(scope){
    var menuList;
    if(scope === null){
      menuList = menu.children;
    } else {
      menuList = scope.$modelValue.children;
    }
    menuList.syncItems();
  }

  $scope.editing = {
    toggle(editScope){ editScope.toggle(); },
    hasChildren(editScope){
      return editScope.$modelValue.hasChildren();
    },
    select(editScope){
      $scope.selectedItem = editScope.$modelValue;
    },
    remove(editScope){
      if($scope.selectedItem == editScope.$modelValue){
        $scope.selectedItem = null;
      }
      editScope.remove();
      syncScope(editScope.$parentNodeScope);
    },
    newTopItem(){
      var item = backend.createMenu();
      menu.children.items.push(item);
      $scope.selectedItem = item;
      menu.children.syncItems();
    },
    newSubItem(editScope){
      var item = backend.createMenu();
      editScope.$modelValue.children.items.push(item);
      $scope.selectedItem = item;
      syncScope(editScope);
    }
  };
  $scope.isSelected = function(editScope){
    return $scope.selectedItem == editScope.$nodeScope.$modelValue;
  };
  $scope.menu = menu;
  $scope.pages = pageList.pages;
  $scope.treeOptions = {
    dropped(event){
      syncScope( event.source.nodesScope.$nodeScope );
      syncScope( event.dest.nodesScope.$nodeScope );
    }
  };
  $scope.isAdmin = isAdmin;
  $scope.menuName = menu.name;

  $scope.selectedItem = null;
}

@Controller( 'MenuNewCtrl', ['$scope'])
export function MenuNewController( $scope ) {
  $scope.menuActions.edit();
}

@Controller('MenuShowCtrl', ['$scope'])
export function MenuShowController($scope) {
  $scope.menuActions.edit();
}

@Controller('MenuEditCtrl', ['$scope'])
export function MenuEditController($scope) {
}
