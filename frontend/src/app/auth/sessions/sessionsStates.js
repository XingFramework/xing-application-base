export default function SessionsConfig( $stateProvider) {
  $stateProvider
    .state( 'root.inner.sessions', {
      url: '^/sign-in',
      controller: 'SessionsCtrl',
      templateUrl: 'auth/sessions.tpl.html',
    })
    .state( 'root.inner.sessionsSuccess', {
      url: '^/signed-in',
      templateUrl: 'auth/sessions-success.tpl.html',
      resolve: {
        isAdmin: function($auth){
          return $auth.validateUser();
        }
      }
    });
}