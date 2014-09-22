import {configuration} from '../../common/config';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';
import {} from '../../../vendor/angular-cookies/angular-cookies';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';

angular.module( `${configuration.appName}.auth`, [
  'ui.router.state',
  'ng-token-auth'
])
.config(function config( $stateProvider, $authProvider) {

  $stateProvider
    .state( 'root.inner.login', {
      url: '^/login',
      controller: 'LoginCtrl',
      templateUrl: 'auth/login.tpl.html',
    })
    .state( 'root.inner.loginSuccess', {
      url: '^/login-success',
      templateUrl: 'auth/login-success.tpl.html',
      resolve: {
        isAdmin($auth){
          return $auth.validateUser();
        }
      }
    });
  $authProvider.configure({
    apiUrl: configuration.serverUrl,
    tokenValidationPath:     'users/validate_token',
    signOutUrl:              'users/sign_out',
    // ng-token-auth expects to setup with email -- we've modified the server
    // side to work with anything but haven't forked ng-token-auth yet.
    emailRegistrationPath:   'users',
    accountUpdatePath:       'users',
    accountDeletePath:       'users',
    passwordResetPath:       'users/password',
    passwordUpdatePath:      'users/password',
    emailSignInPath:         'users/sign_in',
    storage:                 'localStorage',
  });
})
.controller( 'LoginCtrl', function( $scope, $auth, $state) {
  $scope.login = {
    login: '',
    password: ''
  };
  $scope.loginSubmit = function() {
    $auth.submitLogin({user: $scope.login})
      .then(function(resp) {
        $state.go('root.inner.loginSuccess');
      })
      .catch(function(resp) {
        // handle error response
      });
  };

});
