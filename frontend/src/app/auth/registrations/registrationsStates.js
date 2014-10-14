export default function RegistrationsConfig( $stateProvider) {
  $stateProvider
    .state( 'root.inner.registrations', {
      url: '^/sign-up',
      controller: 'RegistrationsCtrl',
      templateUrl: 'auth/registrations/registrations.tpl.html',
    })
    .state( 'root.inner.registrationsSuccess', {
      url: '^/signed-up',
      templateUrl: 'auth/registrations/registrations-success.tpl.html'
    });
}
RegistrationsConfig['$inject'] = ['$stateProvider'];
