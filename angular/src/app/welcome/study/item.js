angular.module( 'MindSwarms.welcome.study.item' , [
  'ui.router',
  'MindSwarms.server'
]).config(function config( $stateProvider ) {
  $stateProvider.state( 'study-item', {
    url: '/study-item/:id',
    views: {
      "main": {
        controller: 'StudyCtrl',
        templateUrl: 'welcome/study/item.tpl.html'
      }
    },
    data:{ pageTitle: 'Study' }
  });
}).controller( 'StudyCtrl', function ( $scope, $stateParams, server ) {
  $scope.study = server.study($stateParams.id);

  $scope.addScreenerQuestion = function(){
    if($scope.study && $scope.study.screeners){
      $scope.study.screeners.push({
        text: "",
        options: [],
        answer_type: 0
      });

      server.update($scope.study);
    }
  };

  $scope.addScreenerOption = function(question){
    if(question.options === undefined) {
      question.options = [];
    }
    question.options.push("");

    server.update($scope.study);
  };

  $scope.removeScreenerOption = function(question, option){
    if(question.options === undefined){
      return;
    }
    question.options = question.options.filter(function(item){
      return item != option;
    });
  };
});
