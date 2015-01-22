import {appName} from 'config';
import {Module, Directive} from 'a1atscript';

@Module(`${appName}.adminNav`)
@Directive('adminNav', [])
export default function adminNav() {
  return {
    restrict: 'E',
    templateUrl: 'adminNav/admin-nav.tpl.html'
  };
}
