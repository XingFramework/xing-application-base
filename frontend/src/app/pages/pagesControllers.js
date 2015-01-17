import slugify from '../../common/slugify';



export function PageNewCtrl( $scope, page ){
  $scope.$emit('metadataSet', page.metadata);
}
PageNewCtrl['$inject'] = [ '$scope', 'page' ];

export function PageEditCtrl( $scope, page ){
  // I think there's potential for improving UX here: duplicate the existing page, edit that -
  // on save, submit that and discard the old page. On cancel, swap it back in.
  // Let admin switch back and forth until they decide "this is good" and save
  //    --jdl
  $scope.nowEditing = true;

  $scope.template = 'pages/templates/' +page.layout + ".tpl.html";
}
PageEditCtrl['$inject'] = [ '$scope', 'page' ];

export function PageShowCtrl( $scope, page ){
  $scope.template = 'pages/templates/' +page.layout + ".tpl.html";
  $scope.$emit('metadataSet', page.metadata);
}
PageShowCtrl['$inject'] = [ '$scope', 'page' ];

export function PagesCtrl( $window, $scope, $state, $stateParams, $sce, page, isAdmin) {
  $scope.pageActions = {
    edit(){
      $state.go('^.edit', {}, {location: false});
    },
    show(){
      $state.go("^.show", {pageUrl: page.shortLink});
    },
    remove(){
      if($window.confirm("This will delete the page - it cannot be undone!")){
        page.remove();
        $state.go("^.^.^.admin.pages");
      }
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
        $state.go("^.show", {pageUrl: page.shortLink});
        return page;
      });
    }
  };
  $scope.nowEditing = false;
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
}
PagesCtrl['$inject'] = [ '$window', '$scope', '$state', '$stateParams', '$sce', 'page', 'isAdmin'];
