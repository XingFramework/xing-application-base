import {configuration} from '../config';
import {} from '../../../vendor/angular/angular';
import {} from '../../../vendor/restangular/restangular';

angular.module( configuration.appName + '.server', [ 'ngResource' ])
.factory('server', function($resource, $http){

  $http.defaults.headers.common.Accept = 'application/json';
  $http.defaults.headers.post['Content-Type'] = 'application/json';
  $http.defaults.headers.put['Content-Type'] = 'application/json';

  var resources = {
    user: $resource('/users/:id'),
    study: $resource('/studies/:id'),
    studyList: $resource('/studies')
  };

  var currentUser;
  var exported = {};

  exported.login = function(user){
    return resources.user.get({email: user.email}, function(user){
      currentUser = user;
    }).$promise;
  };

  return exported;
});
