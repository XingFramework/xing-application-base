import { appName } from '../../common/config';
import {} from "../../../build/templates-app";

angular.module( `${appName}.stateAttrs`,
               [ 'templates-app',
                 'ui.router.state'])
.directive('lrdStateAttrs', ($compile, $state) => {
  function getUiViewName(attrs, inherited) {
    var name = attrs.uiView || attrs.name || '';
    return name.indexOf('@') >= 0 ?  name :  (name + '@' + (inherited ? inherited.state.name : ''));
  }

  return {
    restrict: 'A',
    priority: -500, //uiViewFill is -400
    link(scope, element, attrs, controller, transcludeFn){
      var name = getUiViewName(attrs, element.inheritedData('$uiView'));
      var locals  = name && $state.$current && $state.$current.locals[name];

      var viewStateName = locals.$$state.self.name;
      var className = viewStateName.replace(/.*\./,'');
      var idName = viewStateName.replace(/\./g,'_');

      if(! attrs.id){
        attrs.$set("id", idName);
      }
      attrs.$addClass(className);
    }

  };
});
