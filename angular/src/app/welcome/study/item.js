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

  console.log($scope.study);

  $scope.addScreenerQuestion = function(){
    console.log($scope.study);
    if($scope.study && $scope.study.screeners){
      $scope.study.screeners.push({
        text: "",
        options: "",
        answer_type: 0
      });

      server.update($scope.study);
    }
  };
});
