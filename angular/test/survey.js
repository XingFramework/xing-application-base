describe( 'study section', function() {
  var $scope, $state, $controller, server;

  var responses = {
    existing_user: {
      email: "existing@user.com"
    },
    studies: {
      researcherIndex: [ {
        title: "Test Survey",
        id: 1
      } ],
      researcherItem: {
        id: 1,
        screeners: []
      }
    }
  };

  beforeEach( module( 'MindSwarms.server' ) );
  beforeEach( module( 'MindSwarms.welcome.study' ) );

  beforeEach( inject(function(_$controller_, _$state_, _server_) {
    $scope = {};
    $controller = _$controller_;
    $state = _$state_;
    server = _server_;
  }));

  describe('list controller', function() {
    var listController;

    beforeEach(function() {
      spyOn(server, 'updateStudies').andReturn(responses.studies.researcherIndex);

      listController = $controller('StudyListCtrl', {$scope: $scope});
    });
  });

  describe('item controller', function() {
    var itemController;

    var item;

    beforeEach(function() {
      item = responses.studies.researcherItem;
      spyOn(server, 'study').andReturn(item);
      itemController = $controller('StudyCtrl', {$scope: $scope});
    });

    it('should add a question to study', function() {
      spyOn(server, 'update');
      expect(item.screeners.length).toBe(0);
      $scope.addScreenerQuestion();

      expect(item.screeners.length).toBe(1);
      expect(server.update).toHaveBeenCalled();
    });

    it('should add an option to a question', function() {


    });

    it('should remove an option', function() {

    });

    it('should remove a question', function() {

    });
  });
});
