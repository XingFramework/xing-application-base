import {configuration} from '../../common/config';
import {} from './sessions/sessions';
import {} from './registrations/registrations';
import {} from './confirmations/confirmations';
import {} from './passwords/passwords';
import {} from './config/config';

// remove modules as neccesary here if you don't want complex authorization
angular.module( `${configuration.appName}.auth`, [
  'ng-token-auth',
  `${configuration.appName}.auth.sessions`,
  `${configuration.appName}.auth.registrations`,
  `${configuration.appName}.auth.confirmations`,
  `${configuration.appName}.auth.passwords`,
  `${configuration.appName}.auth.config`
])
.config( function ($authProvider, authConfigProvider) {

  var location = window.location.href;
  var confirmationLocation = location.split("#")[0] + "#/confirmed";
  var passwordResetSuccessLocation = location.split("#")[0] + "#/update-password";

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
    confirmationSuccessUrl:  confirmationLocation,
    passwordResetSuccessUrl: passwordResetSuccessLocation
  });

  // change this to a different key as the auth key
  authConfigProvider.authKey("email");

  // turn this off to remove links to reset password
  authConfigProvider.enableRecovery();

});