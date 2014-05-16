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
      list = angular.fromJson($templateCache.get('json-fixtures/study-index/one.json'));
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
      var jsonString = $templateCache.get('json-fixtures/studies/existing.json');
      item = angular.fromJson(jsonString);
      item.$promise = { then: function(){} };
    }));

    beforeEach(function() {
      spyOn(server, 'study').andReturn(item);
      itemController = $controller('StudyCtrl', {$scope: $scope});

      spyOn(server, 'update');
    });

    it('should add a question to study', function() {
      expect(item.screener_questions.length).toBe(3);
      $scope.addScreenerQuestion();

      expect(item.screener_questions.length).toBe(4);
    });

    it('should add an option to a question', function() {
      expect(item.screener_questions[0].options.length).toBe(3);
      $scope.addScreenerOption(item.screener_questions[0]);
      expect(item.screener_questions[0].options.length).toBe(4);
    });

    it('should remove an option', function() {
      expect(item.screener_questions[0].options.length).toBe(3);
      $scope.removeScreenerOption(item.screener_questions[0], "Tableflip!");
      expect(item.screener_questions[0].options.length).toBe(2);
    });

    it('should remove a question', function() {
      expect(item.screener_questions.length).toBe(3);
      $scope.removeScreenerQuestion(item.screener_questions[0]);
      expect(item.screener_questions.length).toBe(2);
    });
  });
});
