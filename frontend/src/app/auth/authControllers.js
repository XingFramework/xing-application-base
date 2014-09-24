import {appName} from '../../common/config';
import {} from './authModule';

angular.module(`${appName}.auth`)

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
