import { DirectiveObject, Module } from 'a1atscript';
import OnLoginDirective from 'components/OnLoginDirective/OnLoginDirective.js';

@Module('adminOnly', ['ng-token-auth'])
@DirectiveObject('adminOnly', ['$rootScope', '$auth'])
export default class AdminOnly extends OnLoginDirective {

  constructor($rootScope, $auth) {
    super($rootScope, $auth)
    this.restrict = 'E';
    this.scope = true;
    this.transclude = true;
    this.templateUrl = 'components/adminOnly/admin-only.tpl.html';
  }

  onLogout(scope) {
    scope.showAdmin = false;
  }

  onLogin(scope, user) {
    scope.showAdmin = true;
  }

}
