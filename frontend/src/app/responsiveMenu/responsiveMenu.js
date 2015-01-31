import { Module, Directive} from 'a1atscript';
import {} from "../../../build/templates-app";

@Module('responsiveMenu', ['templates-app'])
@Directive('lrdResponsiveMenu')
export default function lrdResponsiveMenu() {
  return {
    restrict: 'E',
    templateUrl: 'responsiveMenu/responsive-menu.tpl.html',
    transclude: true,
    scope: true,
    link(scope, element, attrs) {
      var nav = responsiveNav(".nav-collapse");
    }
  };
}
