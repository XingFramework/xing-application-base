import {Controller} from 'a1atscript';

@Controller( 'RootCtrl', ['$scope', 'menuRoot', '$state', '$rootScope', '$window' ])
export default function RootCtrl( $scope, menuRoot, $state, $rootScope, $window ) {
  $rootScope.$on("$viewContentLoaded", function(event) {
    $window.frontendContentLoaded = true;
  });
  $scope.mainMenu = menuRoot.children;
  $scope.$watch(
    ()=>{ return menuRoot.etag; },
    ()=>{
      $scope.mainMenu = menuRoot.children;
    });
}
