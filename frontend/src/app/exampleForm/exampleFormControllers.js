import {appName} from '../../common/config';
import slugify from '../../common/slugify';
import {} from './exampleFormModule';

angular.module(`${appName}.exampleForm`)

.controller( 'ExampleFormCtrl', function( $scope, page ){
  $scope.$emit('metadataSet', page.metadata);
});

