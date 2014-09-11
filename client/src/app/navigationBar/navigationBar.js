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
      console.log("navigationBar/navigationBar.js:16", "contents", contents);
      var compiledContents;
      return {
        //pre: null,
        post(scope, element){
          console.log("navigationBar/navigationBar.js:21", "scope.menu", scope.menu);
          scope.menu.complete.then(() => {
            scope.pageState = "cms.page";
            // Compile the contents
            if(!compiledContents){ compiledContents = $compile(contents); }
            // Re-add the compiled contents to the element
            compiledContents(scope, function(clone){ element.append(clone); });
          });
        }
      };
    }
  };
});
