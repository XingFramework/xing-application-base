import SignOut from 'components/signOut';
import {Module, DirectiveObject} from 'a1atscript';
import OnLoginDirective from 'components/OnLoginDirective';

@Module( 'sessionLinks', [
  'ng-token-auth',
  SignOut])
@DirectiveObject('lrdSessionLinks', ['$rootScope', '$auth'])
export default class SessionLinks extends OnLoginDirective {
  constructor ($rootScope, $auth) {
    super($rootScope, $auth);
    this.restrict = 'E';
    this.scope = true;
    this.templateUrl = 'components/sessionLinks/session-links.tpl.html';
  }

  onLogin(scope, user) {
    scope.isLoggedIn = true;
  }

  onLogout(scope) {
    scope.isLoggedIn = false;
  }

}
