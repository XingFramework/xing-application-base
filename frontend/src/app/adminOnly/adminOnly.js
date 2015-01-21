import { Directive } from 'a1atscript';

@Directive('adminOnly', ['$rootScope', '$auth'])
function ($rootScope, $auth) {

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
}
