import {appName} from '../../common/config';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';
import {} from '../../../vendor/angular-cookies/angular-cookies';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';
import {} from '../../common/toast/toast';
import {} from '../../common/inflector';
import SessionsConfig from './sessionsStates';
import SessionsController from './SessionsControllers';

angular.module( `${appName}.auth.sessions`, [
  'ui.router.state',
  'ng-token-auth',
  `${appName}.toast`,
  `${appName}`,
  'inflector'
])
.config(SessionsConfig)
.controller(SessionsController)
.provider('authKey', function() {
  var authKeyName;
  authKeyName = "email";
  this.set = function (name) {
    authKeyName = name;
  };
  this.$get = [function authKey() {
    return authKeyName;
  }];
});