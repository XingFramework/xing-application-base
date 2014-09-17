import { appName } from '../../common/config';
import {} from "../../../vendor/FroalaWysiwygEditor/froala_editor.min";
import '../../../vendor/angular-froala/angular-froala';

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
        if(scope.editable.content.length === 0){
          scope.froalaConfig.placeholder = `Add content for ${contentName} here`;
        }
        $http.get('pages/admin-edit.tpl.html', {cache: $templateCache}).then( (template) => {
          $elem.html(template.data);
          $compile($elem.contents())(scope);
        });
      } else {
        $elem.append(scope.editable.content);
      }

    }
  };
});
