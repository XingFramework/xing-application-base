import {configuration} from '../config';
import {} from '../../../vendor/angular/angular';
import {} from '../../../vendor/lodash/lodash.compat';
import {} from '../../../vendor/restangular/restangular';

import {Menu} from './menu';
import {Page} from './page';

angular.module( configuration.appName + '.server', [ 'restangular' ])
.factory('cmsBackend', function(Restangular, $http){
      console.log("getting here 1");

  $http.defaults.headers.common.Accept = 'application/json';
  $http.defaults.headers.post['Content-Type'] = 'application/json';
  $http.defaults.headers.put['Content-Type'] = 'application/json';

  var currentUser;

  return {
    page(slug){
      var response = Restangular.one('page', slug).get();
      var pageResponse = new Page(response);
      console.log("in the cms");
      console.log(pageResponse);
      return pageResponse;
    },
    menu(name){
      var response = Restangular.one('menu', name).get(); // GET /menu/Main
      return new Menu(response);
    }
  };
});
