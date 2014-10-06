export default function SessionsController( $scope, $auth, $state, $lrdToast, Serializer, authKey, Inflector) {
  $scope.session = {
    password: ''
  };
  $scope.session[authKey] = '';
  $scope.humanAuthKey = Inflector.humanize(authKey);

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

}