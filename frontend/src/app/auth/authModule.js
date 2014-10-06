import {configuration} from '../../common/config';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';
import {} from '../../../vendor/angular-cookies/angular-cookies';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';
import {} from '../../common/toast/toast';

angular.module( `${configuration.appName}.auth`, [
  'ng-token-auth',
])
.config( function ($authProvider) {

  var location = window.location.href;
  location = location.split("#")[0] + "#/confirmed";

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

});