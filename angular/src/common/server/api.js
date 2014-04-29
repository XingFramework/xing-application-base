angular.module( 'MindSwarms.server', [
  'ngResource'
]).factory('server', function($resource, $http){

  $http.defaults.headers.common.Accept = 'application/json';
  $http.defaults.headers.post['Content-Type'] = 'application/json';
  $http.defaults.headers.put['Content-Type'] = 'application/json';

  var resources = {
    user: $resource('/users/:id'),
    study: $resource('/studies/:id'),
    studyList: $resource('/studies')
  };

  var templates = {
    study: {
      title: "",
      screener_questions: [{
        text: "",
        options: [" ", " "],
        answer_type: 0
      }]
    }
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
    resource.$save();
  };

  exported.study = function(id){
    if(id == "new") {
      var study = angular.copy(templates.study);
      study.$save = function(){
        resources.studyList.save(study);
      };
      return study;
    } else {
      return resources.study.get({id: id});
    }
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
