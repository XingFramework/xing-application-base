import {appName} from 'config';
import {} from '../../../src/app/auth/passwords/passwords';

describe( 'Passwords controllers', function() {

  beforeEach( module( `${appName}.auth.passwords` ) );

  var $scope, $stateMock, $authMock, $toastMock, mockSerializer;

  beforeEach(inject(function($q) {
    $toastMock = {};
    $toastMock.errorList = jasmine.createSpy('errorList');

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
      requestPasswordReset(password_request) {
        if (password_request.user.email) {
          return $q((resolve, reject) => {
            resolve();
          });
        } else {
          return $q((resolve, reject) => {
            reject({
              data: {
                errors: ["Missing Email"]
              }
            });
          });
        }
      },
      updatePassword(password_update) {
        if (password_update.user.password &&
            (password_update.user.password == password_update.user.passwordConfirmation)) {
          return $q((resolve, reject) => {
            resolve();
          });
        } else {
          return $q((resolve, reject) => {
            reject({
              data: {
                errors: { passwordConfirmation: "must match password" }
              }
            });
          });
        }
      }
    };

    spyOn($authMock, 'requestPasswordReset').and.callThrough();
    spyOn($authMock, 'updatePassword').and.callThrough();

  }));

  describe("Passwords Request Controller", function() {

    beforeEach( inject(function($controller, $rootScope) {
      $scope = $rootScope.$new();
      $controller('PasswordsRequestCtrl', {
        $scope: $scope,
        $state: $stateMock,
        $auth: $authMock,
        $lrdToast: $toastMock,
        Serializer: mockSerializer
      });
      $scope.$apply();
    }));

    it('should assign password request', function(){
      expect($scope.passwordRequest).toEqualData({
        email: ""});
    });

    describe("passwordRequestSubmit", function() {
      describe("with valid request", function() {
        beforeEach(function() {
          $scope.passwordRequest = { email: "bob@bob.com" };
          $scope.passwordRequestSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.requestPasswordReset).toHaveBeenCalled();
        });

        it ("should redirect to the password request success page", function() {
          expect($stateMock.go).toHaveBeenCalledWith("root.inner.passwordsRequestSuccess");
        });

      });

      describe("with invalid request", function() {
        beforeEach(function() {
          $scope.passwordRequest = { email: ''};
          $scope.passwordRequestSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.requestPasswordReset).toHaveBeenCalled();
        });

        it ("should set the toast error message", function() {
          expect($toastMock.errorList).toHaveBeenCalledWith(["Missing Email"]);
        });
      });
    });
  });

  describe("Passwords Update Controller", function() {

    beforeEach( inject(function($controller, $rootScope) {
      $scope = $rootScope.$new();
      $controller('PasswordsUpdateCtrl', {
        $scope: $scope,
        $state: $stateMock,
        $auth: $authMock,
        $lrdToast: $toastMock,
        Serializer: mockSerializer
      });
      $scope.$apply();
    }));

    it('should assign password update', function(){
      expect($scope.passwordUpdate).toEqualData({
        password: "",
        passwordConfirmation: ""
      });
    });

    describe("passwordUpdateSubmit", function() {
      describe("with valid update", function() {
        beforeEach(function() {
          $scope.passwordUpdate = {
            password: "jimbo",
            passwordConfirmation: "jimbo"
          };
          $scope.passwordUpdateSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.updatePassword).toHaveBeenCalled();
        });

        it ("should redirect to the passwords update success page", function() {
          expect($stateMock.go).toHaveBeenCalledWith("root.inner.passwordsUpdateSuccess");
        });

      });

      describe("with invalid request", function() {
        beforeEach(function() {
          $scope.passwordUpdate = {
            password: "jimbo",
            passwordConfirmation: "billyBob"
          };
          $scope.passwordUpdateSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.updatePassword).toHaveBeenCalled();
        });

        it ("should set the toast error message", function() {
          expect($toastMock.errorList).toHaveBeenCalledWith({ passwordConfirmation: "must match password" },
          "We could not update your password because:");
        });
      });
    });
  });
});
