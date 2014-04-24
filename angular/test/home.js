describe( 'home section', function() {
  var homeController, $rootScope, $scope, $httpBackend, $state, server;

  var responses = {
    existing_user: {
      email: "existing@user.com"
    }
  };

  beforeEach( module( 'MindSwarms.server' ) );
  beforeEach( module( 'MindSwarms.welcome.home' ) );
  beforeEach( inject(function(_$rootScope_, _$controller_, _$injector_, _$state_, _server_) {
    $scope = {};
    homeController = _$controller_('HomeCtrl', {$scope: $scope});
    $rootScope = _$rootScope_;
    $httpBackend = _$injector_.get('$httpBackend');
    $state = _$state_;
    server = _server_;
  }));

  beforeEach(function() {
    spyOn($state, 'go');
  });

  describe("with successful login", function() {
    var user;
    beforeEach(function() {
      user = {
        email: "existing@user.com"
      };

      $httpBackend.when("GET", "/users?email=existing@user.com").respond([responses.existing_user]);

      $scope.become(user);
      $httpBackend.flush();
    });

    it("should set the user model in the server", function() {
      expect(server.currentUser().email).toBe(responses.existing_user.email);
    });

    it("should transition to survey list", function() {
      expect($state.go).toHaveBeenCalledWith('study-list');
    });
  });

  describe("with failed login", function() {
    it("should clear the user model in the server", function() {

    });

    it("should remain in the home state", function() {

    });
  });
});
