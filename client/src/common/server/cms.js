import {configuration} from '../config';
import {} from '../../../vendor/angular/angular';
import {} from '../../../vendor/lodash/lodash';
import {} from '../../../vendor/restangular/restangular';
import {} from '../serializer';

import {Menu} from './menu';
import {Page} from './page';

angular.module( configuration.appName + '.server', [ 'restangular', 'serializer' ])
.config( function myAppConfig (RestangularProvider) {
  RestangularProvider.setBaseUrl(configuration.serverUrl);
})
.run( function run (Restangular, RequestInterceptor, ResponseInterceptor) {
  Restangular.addRequestInterceptor(RequestInterceptor);
  Restangular.addResponseInterceptor(ResponseInterceptor);
})
.factory('cmsBackend', function(Restangular, $http){

  $http.defaults.headers.common.Accept = 'application/json';
  $http.defaults.headers.post['Content-Type'] = 'application/json';
  $http.defaults.headers.put['Content-Type'] = 'application/json';

  var currentUser;

  return {
    page(slug){
      var response = Restangular.one('page', slug).get();
      console.log("server/cms.js:21", "response", response);


      // TODO:  this should instantiate the right page class based on the
      // layout field of the page.
      return new Page(response);
    },
    menu(name){
      var response = Restangular.one('navigation', name).get(); // GET /menu/Main
      console.log("server/cms.js:25", "response", response);
      return new Menu(response);
    },
    homepage(){
      var response = Restangular.one('homepage').get();
      console.log("server/cms.js:30", "response", response);
      return new Homepage(response);
    }
  };
});
