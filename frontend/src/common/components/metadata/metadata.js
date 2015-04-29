import {Module,  Controller } from 'a1atscript';

@Module('metadata')
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
    if ( angular.isDefined( metadata.pageStyles ) ) {
      $scope.pageStyles = metadata.pageStyles ;
    }
  };

  $rootScope.$on('metadataSet', function(event, metadata) {
    loadMetadata(metadata);
  });
}
