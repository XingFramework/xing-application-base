import { appName } from '../../common/config';
import {} from '../../../vendor/angular-cookies/angular-cookies';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';

angular.module( `${appName}.adminOnly`, [`${appName}.config`, 'ng-token-auth'])
.directive('adminOnly',
  ['$rootScope', '$auth', function ($rootScope, $auth) {

    function link(scope, element, attrs) {
      scope.showAdmin = false;
      $auth.validateUser().then((user) => {
        scope.showAdmin = true;
      });
      $rootScope.$on('auth:login-success', (ev, user) => {
        scope.showAdmin = true;
      });
      $rootScope.$on('auth:logout-success', (ev, user) => {
        scope.showAdmin = false;
      });
    }
    return {
      restrict: 'E',
      scope: true,
      link: link,
      transclude: true,
      templateUrl: 'adminOnly/admin-only.tpl.html'
    };
  }]);
