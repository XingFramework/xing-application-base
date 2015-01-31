import { Controller } from 'a1atscript';

@Controller('PasswordsRequestCtrl', ['$scope', '$auth', '$state', '$lrdToast', 'Serializer'])
export function PasswordsRequestController( $scope, $auth, $state, $lrdToast, Serializer) {
  $scope.passwordRequest = {
    email: '',
  };

  $scope.passwordRequestSubmit = function() {
    var serializer = new Serializer();

    $auth.requestPasswordReset(serializer.serialize({user: $scope.passwordRequest}))
      .then(function(resp) {
        $state.go('root.inner.passwordsRequestSuccess');
      })
      .catch(function(resp) {
        $lrdToast.errorList(resp.data.errors);
        // handle error response
      });
  };
}

@Controller('PasswordsUpdateCtrl', ['$scope', '$auth', '$state', '$lrdToast', 'Serializer'])
export function PasswordsUpdateController( $scope, $auth, $state, $lrdToast, Serializer) {
  $scope.passwordUpdate = {
    password: '',
    passwordConfirmation: ''
  };

  $scope.passwordUpdateSubmit = function() {
    var serializer = new Serializer();

    $auth.updatePassword(serializer.serialize({user: $scope.passwordUpdate}))
      .then(function(resp) {
        $state.go('root.inner.passwordsUpdateSuccess');
      })
      .catch(function(resp) {
        $lrdToast.errorList(resp.data.errors, "We could not update your password because:");
        // handle error response
      });
  };

}
