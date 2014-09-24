import { configuration } from '../../common/config';
import {} from '../../../vendor/angular-cookies/angular-cookies';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';

angular.module( configuration.appName + '.adminDirectives', [`${configuration.appName}.config`, 'ng-token-auth'])
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
      templateUrl: 'admin/adminOnly.tpl.html'
    };
  }])

.directive('adminNav',
  function($auth, $state) {
    function link(scope, element, attrs) {
      scope.logout = () => {
        $auth.signOut().then((response) => {
          $state.go('root.homepage.show');
        });
      };
    }
    return {
      link: link,
      restrict: 'E',
      templateUrl: 'admin/adminNav.tpl.html'
    };
  });
