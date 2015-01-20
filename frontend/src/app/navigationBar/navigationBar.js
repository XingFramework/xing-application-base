import { appName } from '../../common/config';

@Directive('lrdNavbar', ['$compile', '$state'])
function lrdNavBar($compile, $state) {
  return {
    restrict: 'E',
    templateUrl: 'navigationBar/navigationBar.tpl.html',
    scope: {
      menuId: "@?id",
      menu: "=",
    },
    compile(element, attrs){
      // Break the recursion loop by removing the contents
      var contents = element.contents().remove();
      var compiledContents;
      return {
        //pre: null,
        post(scope, element){
          scope.menu.complete.then(() => {
            scope.pageState = "root.inner.page.show";
            scope.$state = $state;
            // Compile the contents
            if(!compiledContents){ compiledContents = $compile(contents); }
            // Re-add the compiled contents to the element
            compiledContents(scope, function(clone){ element.append(clone); });
          });
        }
      };
    }
  };
}

export var NavigationBar = new Module(`${appName}.navigationBar`,
  ['templates-app',
  'ui.router.state',
  `${appName}.pages`,
  lrdNavbar]);
