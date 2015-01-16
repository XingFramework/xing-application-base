import {appName} from '../../common/config';
import {} from './exampleFormModule';

angular.module(`${appName}.exampleForm`)
.config(function config( $stateProvider ) {
  $stateProvider
    .state( 'root.inner.exampleForm', {
      url: '^/example-form',
      controller: 'ExampleFormCtrl',
      templateUrl: "exampleForm/example-form.tpl.html"
    });
});
