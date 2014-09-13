import {configuration} from '../config';
import {} from '../../../vendor/angular/angular';
import {} from '../../../vendor/lodash/lodash';
import {} from '../../../vendor/restangular/restangular';

import {Menu} from './menu';
import {Page} from './page';

angular.module( configuration.appName + '.server', [ 'restangular' ])
.factory('cmsBackend', function(Restangular, $http){

  $http.defaults.headers.common.Accept = 'application/json';
  $http.defaults.headers.post['Content-Type'] = 'application/json';
  $http.defaults.headers.put['Content-Type'] = 'application/json';

  var currentUser;

  return {
    page(slug){
      var response = Restangular.one('pages', slug).get();
      return new Page(response);
    },
    menu(name){
      var response = Restangular.one('navigation', name).get(); // GET /menu/Main
      console.log("server/cms.js:25", "response", response);
      return new Menu(response);
    }
  };
});
