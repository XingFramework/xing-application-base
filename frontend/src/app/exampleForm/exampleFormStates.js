import {Config} from 'a1atscript';

@Config(['$stateProvider'])
export default function config( $stateProvider ) {
  $stateProvider
    .state( 'root.inner.exampleForm', {
      url: '^/example-form',
      controller: 'ExampleFormCtrl',
      templateUrl: "exampleForm/example-form.tpl.html"
    });
}
