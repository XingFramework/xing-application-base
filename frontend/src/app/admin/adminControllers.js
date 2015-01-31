import {Controller} from "a1atscript";

@Controller('AdminPagesCtrl', ['$scope', '$state', 'pageList'])
export function AdminPagesCtrl( $scope, $state, pageList) {
  $scope.pageList = pageList;
  $scope.pages = pageList.pages;
  $scope.newPage = function(){
    $state.go('^.^.inner.page.new');
  };
  // header info
}

@Controller('AdminMenusCtrl', ['$scope', '$state', 'menuList'])
export function AdminMenusCtrl($scope, $state, menuList) {
  $scope.menus = menuList.menus;
  $scope.newMenu = function(){
    $state.go('^.menu.new');
  };
}

@Controller('AdminDocumentsCtrl')
export function AdminDocumentsCtrl() {
}

@Controller('AdminImagesCtrl')
export function AdminImagesCtrl() {
}
