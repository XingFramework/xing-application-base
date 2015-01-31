import {backendUrl} from 'config';
import Sessions from './sessions/sessions';
import Registrations from './registrations/registrations';
import Confirmations from './confirmations/confirmations';
import Passwords from './passwords/passwords';
import AuthConfig from './config/config';
import {Config, Module} from 'a1atscript';

@Config('$authProvider', 'authConfigProvider')
function authSetup($authProvider, authConfigProvider) {

  var location = window.location.href;
  var confirmationLocation = location.split("#")[0] + "#/confirmed";
  var passwordResetSuccessLocation = location.split("#")[0] + "#/update-password";

  $authProvider.configure({
    apiUrl: backendUrl,
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

}

// remove modules as neccesary here if you don't want complex authorization
var authModule = new Module( 'auth', [
  'ng-token-auth',
  Sessions,
  Registrations,
  Confirmations,
  Passwords,
  AuthConfig,
  authSetup
]);

export default authModule;
