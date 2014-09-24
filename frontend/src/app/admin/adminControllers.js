import {appName} from '../../common/config';
import {} from './adminModule';

angular.module( `${appName}.admin` )

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