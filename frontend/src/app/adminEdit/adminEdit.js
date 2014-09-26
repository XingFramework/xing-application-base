import { appName } from '../../common/config';
import {} from "../../../vendor/FroalaWysiwygEditor/froala_editor.min";
import {} from "../../../vendor/FroalaWysiwygEditor/media_manager.min";
import {} from '../../../vendor/angular-froala/angular-froala';


angular.module(`${appName}.adminEditDirective`, ['froala'])

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
        scope.froalaConfig.imageUploadParam = 'image';
        scope.froalaConfig.imageUploadURL = '/admin/froala_images';
        scope.froalaConfig.imagesLoadURL = '/admin/froala_images';
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
