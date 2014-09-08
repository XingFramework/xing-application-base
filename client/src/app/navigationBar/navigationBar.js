import { configuration } from '../../common/config';
import {} from "../../build/templates-app";

angular.module( `${configuration.appName}.navigationBar`, ['templates-app'])
.directive('lrdNavbar', function ($compile) {
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
          scope.pageState = "cms.page";
          // Compile the contents
          if(!compiledContents){ compiledContents = $compile(contents); }
          // Re-add the compiled contents to the element
          compiledContents(scope, function(clone){ element.append(clone); });
        }
      };
    }
  };
});
