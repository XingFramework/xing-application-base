import {appName} from '../../common/config';
import {} from './authModule';

angular.module(`${appName}.auth`)

.controller( 'SessionsCtrl', function( $scope, $auth, $state, $lrdToast, Serializer) {
  $scope.session = {
    email: '',
    password: ''
  };
  $scope.flash = "";

  $scope.sessionSubmit = function() {
    var serializer = new Serializer();

    $auth.submitLogin(serializer.serialize({user: $scope.session}))
      .then(function(resp) {
        $state.go('root.inner.sessionsSuccess');
      })
      .catch(function(resp) {
        $lrdToast.error(resp.errors);
        // handle error response
      });
  };

})

.controller( 'RegistrationsCtrl', function( $scope, $auth, $state, $lrdToast, Serializer) {
  $scope.registration = {
    email: '',
    emailConfirmation: '',
    password: '',
    passwordConfirmation: ''
  };

  $scope.flash = "";
  $scope.registrationSubmit = function() {
    var serializer = new Serializer();

    $auth.submitRegistration(serializer.serialize({user: $scope.registration}))
      .then(function(resp) {
        $state.go('root.inner.registrationsSuccess');
      })
      .catch(function(resp) {
        $lrdToast.errorList(resp.data.errors, "We cannot process your registration because:");
        // handle error response
      });
  };

});