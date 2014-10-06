import {configuration} from '../../common/config';
import {} from '../../../vendor/angular-cookies/angular-cookies';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';

// remove modules as neccesary here if you don't want complex authorization
angular.module( `${configuration.appName}.auth`, [
  'ng-token-auth',
  `${configuration.appName}.auth.sessions`,
  `${configuration.appName}.auth.registrations`,
  `${configuration.appName}.auth.passwords`
])
.config( function ($authProvider, authKeyProvider) {

  var confirmationLocation = window.location.href;
  confirmationLocation = location.split("#")[0] + "#/confirmed";

  $authProvider.configure({
    apiUrl: configuration.backendUrl,
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
    confirmationSuccessUrl:  location
  });

  // change this to a different key as the auth key
  authKey.set("email");

});