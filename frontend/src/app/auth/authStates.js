import {appName} from '../../common/config';
import {} from './authModule';

angular.module(`${appName}.auth`)

.config(function config( $stateProvider) {

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

});