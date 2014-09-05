import {configuration} from '../config';
import {} from '../../../vendor/angular/angular';
import {} from '../../../vendor/restangular/restangular';

angular.module( configuration.appName + '.server', [ 'Restangular' ])
.factory('cms', function(restangular, $http){

  $http.defaults.headers.common.Accept = 'application/json';
  $http.defaults.headers.post['Content-Type'] = 'application/json';
  $http.defaults.headers.put['Content-Type'] = 'application/json';

  var currentUser;

  return {
    page(slug){
      restangular.get('page', slug); //...or something
    }
  };
});
