angular.module( 'MindSwarms.welcome', [
  'ngResource',
  'templates-app',
  'templates-common',
  'MindSwarms.resources',
  'MindSwarms.welcome.home',
  'MindSwarms.welcome.study',
  'ui.router'
]).config( function myAppConfig ( $stateProvider, $urlRouterProvider ) {
  $urlRouterProvider.otherwise( '/home' );
}).run( function run () {
}).controller( 'AppCtrl', function AppCtrl ( $scope, $location ) {
  $scope.$on('$stateChangeSuccess', function(event, toState, toParams, fromState, fromParams){
    if ( angular.isDefined( toState.data.pageTitle ) ) {
      $scope.pageTitle = toState.data.pageTitle + ' | MindSwarms' ;
    }
  });
});
