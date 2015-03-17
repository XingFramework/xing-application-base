import { Module, DirectiveObject } from 'a1atscript';
import {} from "templates-app";

@Module('responsiveMenu', ['templates-app'])
@DirectiveObject('lrdResponsiveMenu')
export default class ResponsiveMenu {
  constructor() {
    this.restrict = 'E';
    this.templateUrl = 'responsiveMenu/responsive-menu.tpl.html';
    this.transclude = true;
    this.scope = true;
  }

  link(scope, element, attrs) {
    var nav = responsiveNav(".nav-collapse");
  }
}
