import {appName} from '../../common/config';
import {} from './authModule';

angular.module(`${appName}.auth`)

.config(function config( $stateProvider) {
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
    })
    .state( 'root.inner.registrations', {
      url: '^/sign-up',
      controller: 'RegistrationsCtrl',
      templateUrl: 'auth/registrations.tpl.html',
    })
    .state( 'root.inner.registrationsSuccess', {
      url: '^/signed-up',
      templateUrl: 'auth/registrations-success.tpl.html'
    })
    .state( 'root.inner.confirmationsSuccess', {
      url: '^/confirmed',
      templateUrl: 'auth/confirmations-success.tpl.html',
      resolve: {
        isAdmin: function($auth){
          return $auth.validateUser();
        }
      }
    });
});