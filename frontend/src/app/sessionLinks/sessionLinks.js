import { appName } from '../../common/config';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';
import {} from '../signOut/signOut';

angular.module( `${appName}.sessionLinks`, [
  `${appName}.config`,
  'ng-token-auth',
  `${appName}.signOutDirective`])
.directive('lrdSessionLinks',
  ['$rootScope', '$auth', function ($rootScope, $auth) {
    function link(scope, element, attrs) {
      scope.isLoggedIn = false;
      $auth.validateUser().then((user) => {
        scope.isLoggedIn = true;
      });
      $rootScope.$on('auth:login-success', (ev, user) => {
        scope.isLoggedIn = true;
      });
      $rootScope.$on('auth:logout-success', (ev, user) => {
        scope.isLoggedIn = false;
      });
    }
    return {
      restrict: 'E',
      scope: true,
      link: link,
      templateUrl: 'sessionLinks/session-links.tpl.html'
    };
  }]);
