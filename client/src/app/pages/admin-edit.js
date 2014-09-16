import '../../../vendor/jquery/jquery';
import {} from "../../../vendor/FroalaWysiwygEditor/froala_editor.min";
import '../../../vendor/angular-froala/angular-froala';
import { configuration } from '../../common/config';

angular.module(`${configuration.appName}.adminEditDirective`, ['froala'])
.directive('lrdAdminEdits', function($sce) {
  return {
    templateUrl: 'pages/admin-edit.tpl.html',
    scope: true,
    link(scope, elem, attrs) {
      scope.contentBlock = $sce.trustAsHtml(scope.contentBlocks[attrs.contentName]);
      scope.editable = { content: scope.page.contentBody(attrs.contentName) };
      scope.$watch('editable.content', (value)=> {
        scope.page.updateContentBody(attrs.contentName, value);
      });
    }
  };
});
