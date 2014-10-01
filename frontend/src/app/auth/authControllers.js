import {appName} from '../../common/config';
import {} from './authModule';

angular.module(`${appName}.auth`)

.controller( 'SessionsCtrl', function( $scope, $auth, $state, $timeout) {
  $scope.session = {
    email: '',
    password: ''
  };
  $scope.flash = "";
  $scope.sessionSubmit = function() {
    $auth.submitLogin({user: $scope.session})
      .then(function(resp) {
        $state.go('root.inner.sessionsSuccess');
      })
      .catch(function(resp) {
        $scope.flash = resp.errors[0];
        $timeout(() => { $scope.flash = "";}, 5000);
        // handle error response
      });
  };

});
