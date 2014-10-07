import {appName} from '../../../common/config';

angular.module(`${appName}.auth.config`, [])
.provider('authConfig', function() {
  var config = {
    authKey: "email",
    recoverable: false
  };

  this.authKey = function (name) {
    config.authKey = name;
  };

  this.enableRecovery = function() {
    config.recoverable = true;
  };

  this.$get = [function authKey() {
    return config;
  }];
});