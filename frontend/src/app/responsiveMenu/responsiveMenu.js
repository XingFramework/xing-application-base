import { appName } from '../../common/config';
import {} from "../../../build/templates-app";

angular.module( `${appName}.responsiveMenu`, ['templates-app'])
.directive('lrdResponsiveMenu', function () {
  return {
    restrict: 'E',
    templateUrl: 'responsiveMenu/responsive-menu.tpl.html',
    transclude: true,
    scope: true,
    link(scope, element, attrs) {
      var nav = responsiveNav(".nav-collapse");
    }
  };
});
