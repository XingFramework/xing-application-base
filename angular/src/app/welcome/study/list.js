angular.module( 'MindSwarms.welcome.study.list', [
  'ui.router',
  'MindSwarms.server'
]).config(function config( $stateProvider ) {
/**
 * Each section or module of the site can also have its own routes. AngularJS
 * will handle ensuring they are all available at run-time, but splitting it
 * this way makes each module more "self-contained".
 */
  $stateProvider.state( 'study-list', {
    //url: '/home',
    views: {
      "main": {
        controller: 'StudyListCtrl',
        templateUrl: 'welcome/study/list.tpl.html'
      }
    },
    data:{ pageTitle: 'Studies' }
  });
}).controller( 'StudyListCtrl', function( $scope, $state, server ) {
  $scope.studies = server.updateStudies();

  $scope.choose = function(study){
    $state.go('study-item', {id: study.id});
  };
});
