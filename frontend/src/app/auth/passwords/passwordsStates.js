export default function PasswordsConfig( $stateProvider) {
  $stateProvider
    .state( 'root.inner.passwordsRequest', {
      url: '^/reset-password',
      controller: 'PasswordsRequestCtrl',
      templateUrl: 'auth/passwords/passwords-request.tpl.html'
    })
    .state( 'root.inner.passwordsRequestSuccess', {
      url: '^/reset-password-sent',
      templateUrl: 'auth/passwords/passwords-request-success.tpl.html',
    })
    .state( 'root.inner.passwordsUpdate', {
      url: '^/update-password',
      controller: 'PasswordsUpdateCtrl',
      templateUrl: 'auth/passwords/passwords-update.tpl.html',
      resolve: {
        isAdmin: function($auth){
          return $auth.validateUser();
        }
      }
    })
    .state( 'root.inner.passwordsUpdateSuccess', {
      url: '^/updated-password',
      templateUrl: 'auth/passwords/passwords-update-success.tpl.html',
      resolve: {
        isAdmin: function($auth){
          return $auth.validateUser();
        }
      }
    });
}
PasswordsConfig['$inject'] = ['$stateProvider'];
