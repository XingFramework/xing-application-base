import '../../../vendor/jquery/jquery';
import '../../../vendor/angular-froala/angular-froala';
import { configuration } from '../../common/config';

angular.module(`${configuration.appName}.adminEditDirective`, [])
.directive('lrdAdminEdit', function() {
  return {
    templateUrl: 'pages/admin-edit.tpl.html',
    scope: true,
    controller($scope, $attrs, $sce) {
      $scope.contentBlock = $sce.trustAsHtml($scope.contentBlocks[$attrs.contentName]);
      $scope.adminContentBlock = $scope.contentBlocks[$attrs.contentName];
    }
  };
});
