angular.module( 'MindSwarms.server', [
  'ngResource'
]).factory('server', function($resource){
  var resources = {
    user: $resource('/users/:id'),
    study: $resource('studies/:id'),
  };

  var currentUser;
  var currentStudies;

  var exported = {
  };

  exported.updateStudies = function(){
    if(this.currentRole() != "Researcher"){
      return [];
    }

    currentStudies = resources.study.query({owner: this.currentUser().id});
    return currentStudies;
  };

  exported.currentStudies = function(){
    return currentStudies;
  };

  exported.update = function(resource){
    resource.$put();
  };

  exported.study = function(id){
    return resource.study.get({id: id});
  };

  exported.login = function(user){
    return resources.user.query({email: user.email}, function(users){
      if(users.length > 0){
        currentUser = users[0];
      }
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
