import {appName} from '../../common/config';
import {} from './adminModule';

angular.module( `${appName}.admin` )

.controller( 'AdminPagesCtrl', function( $scope, $state, pageList) {
  $scope.pageList = pageList;
  $scope.pages = pageList.pages;
  $scope.newPage = function(){
    $state.go('^.^.inner.page.new');
  };
  // header info
})
.controller( 'AdminMenusCtrl', function($scope, $state, menuList) {
  $scope.menus = menuList.menus;
  $scope.newMenu = function(){
    $state.go('^.menu.new');
  };
})
.controller( 'AdminDocumentsCtrl', function() {

})
.controller( 'AdminImagesCtrl', function() {

});
