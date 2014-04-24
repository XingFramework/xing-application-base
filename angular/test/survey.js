describe( 'study section', function() {
  var $scope, $state, $controller, server;

  beforeEach( module( 'MindSwarms.server' ) );
  beforeEach( module( 'MindSwarms.welcome.study' ) );
  beforeEach( module( 'fixtureCache' ) );

  beforeEach( inject(function(_$controller_, _$state_, _server_) {
    $scope = {};
    $controller = _$controller_;
    $state = _$state_;
    server = _server_;
  }));

  describe('list controller', function() {
    var listController;

    var list;

    beforeEach(inject(function($templateCache) {
      list = angular.fromJson($templateCache.get('json-fixtures/study-index.json'));
    }));

    beforeEach(function() {
      spyOn(server, 'updateStudies').andReturn(list);

      listController = $controller('StudyListCtrl', {$scope: $scope});
    });
  });

  describe('item controller', function() {
    var itemController;

    var item;

    beforeEach(inject(function($templateCache) {
      var jsonString = $templateCache.get('json-fixtures/researcher-study.json')
      console.log(jsonString);
      item = angular.fromJson(jsonString);
    }));

    beforeEach(function() {
      spyOn(server, 'study').andReturn(item);
      itemController = $controller('StudyCtrl', {$scope: $scope});

      spyOn(server, 'update');
    });

    it('should add a question to study', function() {
      expect(item.screeners.length).toBe(1);
      $scope.addScreenerQuestion();

      expect(item.screeners.length).toBe(2);
      expect(server.update).toHaveBeenCalled();
    });

    it('should add an option to a question', function() {
      expect(item.screeners[0].options.length).toBe(3);
      $scope.addScreenerOption(item.screeners[0]);
      expect(item.screeners[0].options.length).toBe(4);
      expect(server.update).toHaveBeenCalled();
    });

    it('should remove an option', function() {
      expect(item.screeners[0].options.length).toBe(3);
      $scope.removeScreenerOption(item.screeners[0], "Tableflip!");
      expect(item.screeners[0].options.length).toBe(2);
      expect(server.update).toHaveBeenCalled();
    });

    it('should remove a question', function() {

    });
  });
});
