import {configuration} from '../config';
import {} from '../serializer';
import {Config, Run, Module} from 'a1atscript';
import Backend from '../resources/AppBackend';

@Config(['RestangularProvider'])
function myAppConfig (RestangularProvider) {
  RestangularProvider.setBaseUrl(configuration.backendUrl);
}

@Run(['Restangular', 'RequestInterceptor', 'RequestInterceptor', '$http'])
function run (Restangular, RequestInterceptor, ResponseInterceptor, $http) {
  Restangular.addRequestInterceptor(RequestInterceptor);
  Restangular.addResponseInterceptor(ResponseInterceptor);
  $http.defaults.headers.common.Accept = 'application/json';
  $http.defaults.headers.post['Content-Type'] = 'application/json';
  $http.defaults.headers.put['Content-Type'] = 'application/json';
}

var BackendModule = new Module( configuration.appName + '.backend',
  [ 'restangular',
  'serializer',
  Backend,
  myAppConfig,
  run ]);

export default BackendModule;
