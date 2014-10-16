import { appName } from '../../common/config';
import {} from "../../../build/templates-app";

angular.module( `${appName}.stateAttrs`,
               [ 'templates-app',
                 'ui.router.state'])
.directive('lrdStateAttrs', ($compile, $state) => {
  return {
    restrict: 'A',
    priority: 100, //uiViewFill is -400
    link(scope, element, attrs, controller, transcludeFn){
      console.log("stateAttrs/stateAttrs.js:13", "element", element);
      console.log("stateAttrs/stateAttrs.js:13", "element.data", element.data('$uiView'));
      console.log("stateAttrs/stateAttrs.js:13", "element.data", element.inheritedData('$uiView'));
    }
  };
});
