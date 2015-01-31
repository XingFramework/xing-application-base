export default class OnLoginDirective {

  constructor($rootScope, $auth) {
    this.$rootScope = $rootScope;
    this.$auth = $auth;
  }

  link(scope, element, attrs) {
    this.onLogout(scope);
    this.$auth.validateUser().then((user) => {
      this.onLogin(scope, user);
    });
    this.$rootScope.$on('auth:login-success', (ev, user) => {
      this.onLogin(scope, user);
    });
    this.$rootScope.$on('auth:logout-success', (ev, user) => {
      this.onLogout(scope);
    });
  }

}
