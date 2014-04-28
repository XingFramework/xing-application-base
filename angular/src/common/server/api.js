angular.module( 'MindSwarms.server', [
  'ngResource'
]).factory('server', function($resource, $http){

  $http.defaults.headers.common.Accept = 'application/json';
  $http.defaults.headers.post['Content-Type'] = 'application/json';
  $http.defaults.headers.put['Content-Type'] = 'application/json';

  var resources = {
    user: $resource('/users/:id'),
    study: $resource('/studies/:id'),
  };

  var currentUser;
  var currentStudies;

  var exported = {
  };

  exported.updateStudies = function(){
    if(this.currentRole() != "Researcher"){
      return [];
    }

    currentStudies = resources.study.query({owner_id: this.currentUser().id});
    return currentStudies;
  };

  exported.currentStudies = function(){
    return currentStudies;
  };

  exported.update = function(resource){
    resource.$put();
  };

  exported.study = function(id){
    return resources.study.get({id: id});
  };

  exported.login = function(user){
    return resources.user.get({email: user.email}, function(user){
      currentUser = user;
    }).$promise;
  };

  exported.currentUser = function(){
    return currentUser;
  };

  exported.currentRole = function(){
    if(currentUser !== undefined){
      return "Researcher";
    }

    return "none";
  };

  return exported;
});
