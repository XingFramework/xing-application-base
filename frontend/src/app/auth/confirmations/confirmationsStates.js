export default function ConfirmationsConfig( $stateProvider) {
  $stateProvider
    .state( 'root.inner.confirmationsSuccess', {
      url: '^/confirmed',
      templateUrl: 'auth/confirmations/confirmations-success.tpl.html',
      resolve: {
        isAdmin: ['$auth', function($auth){
          return $auth.validateUser();
        }]
      }
    });
}

ConfirmationsConfig['$inject'] = ['$stateProvider'];