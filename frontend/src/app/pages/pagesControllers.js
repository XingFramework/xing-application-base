import {appName} from '../../common/config';
import slugify from '../../common/slugify';
import {} from './pagesModule';

angular.module(`${appName}.pages`)

.controller( 'PageNewCtrl', function( $scope ){

})

.controller( 'PageEditCtrl', function( $scope ){
  // I think there's potential for improving UX here: duplicate the existing page, edit that -
  // on save, submit that and discard the old page. On cancel, swap it back in.
  // Let admin switch back and forth until they decide "this is good" and save
  //    --jdl
  $scope.nowEditing = true;
})

.controller( 'PagesCtrl', function( $scope, $state, $stateParams, $sce, page, isAdmin) {
  $scope.pageActions = {
    edit(){
      $state.go('^.edit', {}, {location: false});
    },
    show(){
      $state.go("^.show", {pageUrl: page.selfUrl});
    },
    save(){
      if(!page.title){
        page.title = angular.element(page.headline)[0].innerText;
      }
      if(!page.urlSlug){
        page.urlSlug = slugify(page.title);
      }
      page.save();
      page.complete.then((page) => {
        $state.go("^.show");
        return page;
      });
    }
  };
  $scope.nowEditing = false;
  $scope.edit = function(){
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
