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
}).controller( 'StudyCtrl', function ( $state, $scope, $stateParams, server ) {
  $scope.study = server.study($stateParams.id);

  $scope.addScreenerQuestion = function(){
    if($scope.study && $scope.study.screener_questions){
      $scope.study.screener_questions.push({
        text: "",
        options: [],
        answer_type: 0
      });
    }
  };


  $scope.addScreenerOption = function(question){
    if(question.options === undefined) {
      question.options = [];
    }
    question.options.push("");
  };

  $scope.removeScreenerOption = function(question, index){
    if(question.options === undefined){
      return;
    }

    question.options.splice(index, 1);

      //= question.options.filter(function(item){
      //return item != option;
    //});
  };

  $scope.removeScreenerQuestion = function(question){
    $scope.study.screener_questions = $scope.study.screener_questions.filter(function(item){
      return item != question;
    });
  };

  $scope.saveStudy = function() {
    $scope.study.user_id = server.currentUser().id;
    server.update($scope.study);
    $state.go('study-list');
  };
});
