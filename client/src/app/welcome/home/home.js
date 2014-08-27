angular.module( 'MindSwarms.welcome.home', [
  'ui.router',
  'plusOne',
  'MindSwarms.server'
]).config(function config( $stateProvider ) {
/**
 * Each section or module of the site can also have its own routes. AngularJS
 * will handle ensuring they are all available at run-time, but splitting it
 * this way makes each module more "self-contained".
 */
  $stateProvider.state( 'home', {
    url: '/home',
    views: {
      "main": {
        controller: 'HomeCtrl',
        templateUrl: 'welcome/home/home.tpl.html'
      }
    },
    data:{ pageTitle: 'Home' }
  });
}).controller( 'HomeCtrl', function HomeController( $rootScope, $scope, $state, server ) {
  $scope.become = function(user){
    server.login(user).then(function(){
      if( server.currentRole() == 'Researcher' ){
        $state.go('study-list');
      }
    });
  };
});
