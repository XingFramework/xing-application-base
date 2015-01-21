import { Controller } from 'a1atscript'

@Controller( 'MetadataCtrl', ['$scope', '$rootScope'])
export default function MetadataCtrl($scope, $rootScope) {
  var loadMetadata = function (metadata) {
    if ( angular.isDefined( metadata.pageTitle ) ) {
      $scope.pageTitle = metadata.pageTitle + ' | Logical Reality' ;
    }
    if ( angular.isDefined( metadata.pageKeywords ) ) {
      $scope.pageKeywords = metadata.pageKeywords;
    }
    if ( angular.isDefined( metadata.pageDescription ) ) {
      $scope.pageDescription = metadata.pageDescription;
    }
    if ( angular.isDefined( metadata.pageCss ) ) {
      $scope.pageCss = metadata.pageCss ;
    }
  };

  $rootScope.$on('metadataSet', function(event, metadata) {
    loadMetadata(metadata);
  });
}
