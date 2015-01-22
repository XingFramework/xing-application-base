import {appName} from '../../common/config';
import {Module, Directive} from 'a1atscript';

@Directive('adminNav', [])
function adminNav() {
  return {
    restrict: 'E',
    templateUrl: 'adminNav/admin-nav.tpl.html'
  };
}

var adminNavModule = new Module(`${appName}.adminNav`, [adminNav]);
export default adminNavModule;
