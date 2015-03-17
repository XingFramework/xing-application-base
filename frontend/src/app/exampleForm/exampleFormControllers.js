import {Controller} from 'a1atscript';
import slugify from 'slugify';

@Controller( 'ExampleFormCtrl',['$scope', 'page'])
export default function ExampleFormCtrl( $scope, page ){
  $scope.$emit('metadataSet', page.metadata);
}
