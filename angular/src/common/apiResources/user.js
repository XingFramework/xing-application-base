angular.module( 'MindSwarms.resources', [
  'ngResource'
]).factory('User', function($resource){
  return $resource('/users/:id');
});
