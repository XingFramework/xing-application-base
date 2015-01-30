import {} from "../../../build/templates-app";
import Pages from '../pages/pages';
import { Module, DirectiveObject } from 'a1atscript';

@Module('navigationBar', ['ui.router.state', 'templates-app', Pages])
@DirectiveObject('lrdNavbar', ['$compile', '$state'])
export default class Navbar {

  constructor($compile, $state) {
    this.$compile = $compile;
    this.$state = $state;
    this.restrict = 'E';
    this.templateUrl = 'navigationBar/navigationBar.tpl.html';
    this.scope = {
      menuId: "@?id",
      menu: "=",
    };
  }

  link(scope, element){
    scope.menu.complete.then(() => {
      scope.pageState = "root.inner.page.show";
      scope.$state = this.$state;
      // Compile the contents
      if(!this.compiledContents){ this.compiledContents = this.$compile(this.contents); }
      // Re-add the compiled contents to the element
      this.compiledContents(scope, function(clone){ element.append(clone); });
    });
  }

  compile(element, attrs){
    // Break the recursion loop by removing the contents
    this.contents = element.contents().remove();
  }
}
