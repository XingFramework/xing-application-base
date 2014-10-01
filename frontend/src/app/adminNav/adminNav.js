import { appName } from '../../common/config';
import {} from '../../../vendor/angular-cookies/angular-cookies';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';
import {} from '../signOut/signOut';

angular.module(`${appName}.adminNav`, [`${appName}.config`, 'ng-token-auth',
  `${appName}.signOutDirective`])
.directive('adminNav',
  function() {
    return {
      restrict: 'E',
      templateUrl: 'adminNav/admin-nav.tpl.html'
    };
  });
