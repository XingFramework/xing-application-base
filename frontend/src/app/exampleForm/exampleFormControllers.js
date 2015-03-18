import {Controller} from 'a1atscript';
import slugify from 'framework/slugify.js';

@Controller( 'ExampleFormCtrl',['$scope', 'page'])
export default function ExampleFormCtrl( $scope, page ){
  $scope.$emit('metadataSet', page.metadata);
}
