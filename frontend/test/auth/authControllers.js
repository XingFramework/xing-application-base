import {appName} from '../../src/common/config';
import {} from '../../src/app/auth/auth';

describe( 'Auth controllers', function() {

  beforeEach( module( `${appName}.auth` ) );

  var $scope, $stateMock, $authMock, $timeoutMock, sessionsCtrl, authSpy;

  beforeEach(inject(function($q) {

    $timeoutMock = jasmine.createSpy();

    $stateMock = {
      go(state){}
    };

    spyOn($stateMock, 'go').and.callThrough();

    $authMock = {
      submitLogin(session) {
        if ((session.user.email == "bob") && (session.user.password = "password")) {
          return $q((resolve, reject) => {
            resolve();
          });
        } else {
          return $q((resolve, reject) => {
            reject({errors: ["Invalid Login"]});
          });
        }
      }
    };

    spyOn($authMock, 'submitLogin').and.callThrough();

  }));

  beforeEach( inject(function($controller, $rootScope) {
    $scope = $rootScope.$new();
    sessionsCtrl = $controller('SessionsCtrl', {
      $scope: $scope,
      $state: $stateMock,
      $auth: $authMock,
      $timeout: $timeoutMock
    });
    $scope.$apply();
  }));

  it('should assign session', function(){
    expect($scope.session).toEqual({email: "", password: ""});
  });

  it('should assign flash', function(){
    expect($scope.flash).toEqual("");
  });

  describe("submitSession", function() {
    describe("with valid login", function() {
      beforeEach(function() {
        $scope.session = { email: "bob", password: "password" };
        $scope.sessionSubmit();
        $scope.$apply();
      });

      it ("should call the auth service", function() {
        expect($authMock.submitLogin).toHaveBeenCalled();
      });

      it ("should redirect to the sign in success page", function() {
        expect($stateMock.go).toHaveBeenCalledWith("root.inner.sessionsSuccess");
      });

    });

    describe("with invalid login", function() {
      beforeEach(function() {
        $scope.session = { email: "jill", password: "wrong password" };
        $scope.sessionSubmit();
        $scope.$apply();
      });

      it ("should call the auth service", function() {
        expect($authMock.submitLogin).toHaveBeenCalled();
      });

      it ("should set the flash error message", function() {
        expect($scope.flash).toEqual("Invalid Login");
      });

      it ("should set a timeout for removing the flash", function() {
        expect($timeoutMock).toHaveBeenCalled();
      });
    });
  });

});
