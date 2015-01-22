import {appName} from 'config';
import {Provider, Module} from 'a1atscript';

@Module(`${appName}.auth.config`)
@Provider('authConfig')
export default function authConfig() {
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
}
