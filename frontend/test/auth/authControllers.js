import {appName} from '../../src/common/config';
import {} from '../../src/app/auth/auth';

describe( 'Auth controllers', function() {

  beforeEach( module( `${appName}.auth` ) );

  var $scope, $stateMock, $authMock, $timeoutMock, sessionsCtrl, mockSerializer, authSpy;

  beforeEach(inject(function($q) {

    $timeoutMock = jasmine.createSpy();

    $stateMock = {
      go(state){}
    };

    mockSerializer = function() {
      this.serialize = function(data) {
        return data;
      };
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
      },
      submitRegistration(registration) {
        if (registration.user.email &&
            (registration.user.email == registration.user.emailConfirmation) &&
            registration.user.password &&
            (registration.user.password == registration.user.passwordConfirmation)) {
          return $q((resolve, reject) => {
            resolve();
          });
        } else {
          return $q((resolve, reject) => {
            reject({errors: ["Email must match confirmation"]});
          });
        }
      }
    };

    spyOn($authMock, 'submitLogin').and.callThrough();
    spyOn($authMock, 'submitRegistration').and.callThrough();

  }));

  describe("Sessions Controller", function() {

    beforeEach( inject(function($controller, $rootScope) {
      $scope = $rootScope.$new();
      sessionsCtrl = $controller('SessionsCtrl', {
        $scope: $scope,
        $state: $stateMock,
        $auth: $authMock,
        $timeout: $timeoutMock,
        Serializer: mockSerializer
      });
      $scope.$apply();
    }));

    it('should assign session', function(){
      expect($scope.session).toEqualData({email: "", password: ""});
    });

    it('should assign flash', function(){
      expect($scope.flash).toEqual("");
    });

    describe("sessionSubmit", function() {
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

  describe("Registrations Controller", function() {

    beforeEach( inject(function($controller, $rootScope) {
      $scope = $rootScope.$new();
      sessionsCtrl = $controller('RegistrationsCtrl', {
        $scope: $scope,
        $state: $stateMock,
        $auth: $authMock,
        $timeout: $timeoutMock,
        Serializer: mockSerializer
      });
      $scope.$apply();
    }));

    it('should assign session', function(){
      expect($scope.registration).toEqualData({
        email: "",
        emailConfirmation: "",
        password: "",
        passwordConfirmation: ""});
    });

    it('should assign flash', function(){
      expect($scope.flash).toEqual("");
    });

    describe("registrationSubmit", function() {
      describe("with valid sign up", function() {
        beforeEach(function() {
          $scope.registration = { email: "bob@bob.com",
            emailConfirmation: "bob@bob.com",
            password: "password",
            passwordConfirmation: "password"
          };
          $scope.registrationSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.submitRegistration).toHaveBeenCalled();
        });

        it ("should redirect to the sign in success page", function() {
          expect($stateMock.go).toHaveBeenCalledWith("root.inner.registrationsSuccess");
        });

      });

      describe("with invalid login", function() {
        beforeEach(function() {
          $scope.registration = { email: "bob@bob.com",
            emailConfirmation: "jill@jill.com",
            password: "wrong password",
            passwordConfirmation: "wrong password"
          };
          $scope.registrationSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.submitRegistration).toHaveBeenCalled();
        });

        it ("should set the flash error message", function() {
          expect($scope.flash).toEqual("Email must match confirmation");
        });

        it ("should set a timeout for removing the flash", function() {
          expect($timeoutMock).toHaveBeenCalled();
        });
      });
    });
  });
});
