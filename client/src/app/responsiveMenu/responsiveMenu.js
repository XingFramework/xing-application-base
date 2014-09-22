import { configuration } from '../../common/config';
import {} from "../../build/templates-app";
import {} from '../../../vendor/responsive-nav/responsive-nav';

angular.module( `${configuration.appName}.responsiveMenu`, ['templates-app'])
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
