import {configuration} from '../config';
import {} from '../../../vendor/angular/angular';
import {} from '../../../vendor/lodash/lodash.compat';
import {} from '../../../vendor/restangular/restangular';

import {Menu} from './menu';

angular.module( configuration.appName + '.server', [ 'restangular' ])
.factory('cmsBackend', function(Restangular, $http){

  $http.defaults.headers.common.Accept = 'application/json';
  $http.defaults.headers.post['Content-Type'] = 'application/json';
  $http.defaults.headers.put['Content-Type'] = 'application/json';

  var currentUser;

  return {
    page(slug){
      Restangular.get('page', slug); //...or something
    },
    menu(name){
      var response = Restangular.one('menu', name).get(); // GET /menu/Main
      return new Menu(response);
    }
  };
});
