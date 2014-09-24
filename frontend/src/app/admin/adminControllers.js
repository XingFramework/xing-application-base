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
.controller( 'AdminMenusCtrl', function() {

})
.controller( 'AdminDocumentsCtrl', function() {

})
.controller( 'AdminImagesCtrl', function() {

});
