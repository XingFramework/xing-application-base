export default function ConfirmationsConfig( $stateProvider) {
  $stateProvider
    .state( 'root.inner.confirmationsSuccess', {
      url: '^/confirmed',
      templateUrl: 'auth/confirmations/confirmations-success.tpl.html',
      resolve: {
        isAdmin: function($auth){
          return $auth.validateUser();
        }
      }
    });
}