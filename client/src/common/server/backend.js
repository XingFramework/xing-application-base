import {configuration} from '../config';
import {} from '../../../vendor/angular/angular';
import {} from '../../../vendor/lodash/lodash';
import {} from '../../../vendor/restangular/restangular';
import {} from '../serializer';

import Backend from '../resources/AppServer.js';

angular.module( configuration.appName + '.server', [ 'restangular', 'serializer' ])
.config( function myAppConfig (RestangularProvider) {
  RestangularProvider.setBaseUrl(configuration.serverUrl);
})
.run( function run (Restangular, RequestInterceptor, ResponseInterceptor) {
  Restangular.addRequestInterceptor(RequestInterceptor);
  Restangular.addResponseInterceptor(ResponseInterceptor);
})
.factory('backend', function(Restangular, $http){

  $http.defaults.headers.common.Accept = 'application/json';
  $http.defaults.headers.post['Content-Type'] = 'application/json';
  $http.defaults.headers.put['Content-Type'] = 'application/json';

  var currentUser;

  return new Backend(Restangular);
});
