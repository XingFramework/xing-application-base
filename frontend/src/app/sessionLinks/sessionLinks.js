import SignOut from '../signOut/signOut';
import {Module, Directive} from 'a1atscript';

@Module( 'sessionLinks', [
  'ng-token-auth',
  SignOut])
@Directive('lrdSessionLinks', ['$rootScope', '$auth'])
export default function lrdSessionLinks($rootScope, $auth) {
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
}
