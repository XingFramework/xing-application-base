import {appName} from '../../common/config';
import {} from './pagesModule';

angular.module(`${appName}.pages`)

.controller( 'PageNewCtrl', function( $state ){
  $state.go("^.edit");
})

.controller( 'PageEditCtrl', function( $scope, $state, page ){
  // I think there's potential for improving UX here: duplicate the existing page, edit that -
  // on save, submit that and discard the old page. On cancel, swap it back in.
  // Let admin switch back and forth until they decide "this is good" and save
  //    --jdl
  $scope.nowEditing = true;
  $scope.cancelEdit = function(){
    $state.go("^.show");
  };
  $scope.savePage = function(){
    page.save();
    page.complete.then((page) => {
    $state.go("^.show");
      return page;
    });
  };
})

.controller( 'PagesCtrl', function( $scope, $state, $stateParams, $sce, page, isAdmin) {
  $scope.nowEditing = false;
  $scope.edit = function(){
    $state.go('^.edit');
  };

  $scope.froalaConfig = { };

  $scope.page = page;
  $scope.isAdmin = isAdmin;
  $scope.contentBlocks = {};
  $scope.template = 'pages/templates/' +page.layout + ".tpl.html";

  for(var name in page.contentBlocks) {
    if (page.contentBlocks.hasOwnProperty(name)) {
      $scope.contentBlocks[name] = $sce.trustAsHtml(page.contentBlocks[name]);
    }
  }
  // header info
  $scope.$emit('metadataSet', page.metadata);
});
