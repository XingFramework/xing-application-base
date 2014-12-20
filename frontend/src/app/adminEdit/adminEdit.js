import { appName, backendUrl} from '../../common/config';

angular.module(`${appName}.adminEditDirective`, ['froala'])

.factory('froalaConfig', function($auth) {
  var config = {
    buttons: ["bold", "italic", "underline", "strikeThrough", "sep", "formatBlock", "align", "outdent", "indent", "insertHorizontalRule", "sep", "createLink", "insertImage","uploadFile", "undo", "redo", "html"],
    fileUploadParam: 'document',
    fileUploadURL: `${backendUrl}admin/froala_documents/`,
    imageUploadParam: 'image',
    imageUploadURL: `${backendUrl}admin/froala_images/`,
    imagesLoadURL: `${backendUrl}admin/froala_images/`,
    imageDeleteURL: `${backendUrl}admin/froala_images/delete`,
    crossDomain: true
  };
  config.headers = $auth.retrieveData('auth_headers');
  return config;
})

.directive('lrdAdminEditable', function($sce, $compile, $http, $templateCache) {
  return {
    restrict: 'A',
    scope: true,
    transclude: true,
    link (scope, $elem, attrs, _ctrl, $transclude) {
      var contentName = attrs.lrdAdminEditable;
      scope.editable = scope.page.contentBody(contentName);

      if(scope.nowEditing){
        scope.froalaConfig.placeholder = "";
        if(scope.editable.content.length === 0){
          scope.froalaConfig.placeholder = `Add content for ${contentName} here`;
        }
        $http.get('adminEdit/admin-edit.tpl.html', {cache: $templateCache}).then( (template) => {
          $elem.html(template.data);
          $compile($elem.contents())(scope);
        });
      } else {
        $elem.append(scope.editable.content);
      }

    }
  };
});
