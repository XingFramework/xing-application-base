import '../../../vendor/jquery/jquery';
import {} from "../../../vendor/FroalaWysiwygEditor/froala_editor.min";
import '../../../vendor/angular-froala/angular-froala';
import { configuration } from '../../common/config';

angular.module(`${configuration.appName}.adminEditDirective`, ['froala'])
.directive('lrdAdminEdits', function() {
  return {
    templateUrl: 'pages/admin-edit.tpl.html',
    scope: true,
    controller($scope, $attrs, $sce) {
      $scope.contentBlock = $sce.trustAsHtml($scope.contentBlocks[$attrs.contentName]);
      $scope.adminContentBlock = $scope.contentBlocks[$attrs.contentName];
    }
  };
});
