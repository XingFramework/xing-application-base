import {} from "../../../build/templates-app";
import {Module, DirectiveObject} from 'a1atscript';

@Module( 'stateAttrs', [ 'templates-app', 'ui.router.state'])
@DirectiveObject('lrdStateAttrs', ['$compile', '$state'])
export default class StateAttrs {
  constructor($compile, $state) {
    this.$compile = $compile;
    this.$state = $state;
    this.restrict = 'A';
    this.priority = -500;
  }

  getUiViewName(attrs, inherited) {
    var name = attrs.uiView || attrs.name || '';
    return name.indexOf('@') >= 0 ?  name :  (name + '@' + (inherited ? inherited.state.name : ''));
  }

  link(scope, element, attrs, controller, transcludeFn){
    var name = this.getUiViewName(attrs, element.inheritedData('$uiView'));
    var locals  = name && this.$state.$current && this.$state.$current.locals[name];
    if (locals) {
      var viewStateName = locals.$$state.self.name;
      var className = viewStateName.replace(/.*\./,'');
      var idName = viewStateName.replace(/\./g,'_');

      if(! attrs.id){
        attrs.$set("id", idName);
      }
      attrs.$addClass(className);
    }
  }
}
