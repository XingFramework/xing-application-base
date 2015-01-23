import {Module, Directive} from 'a1atscript';
import SignOutDirective from '../signOut/signOut';

@Module('adminNav', ['ng-token-auth', SignOutDirective])
@Directive('adminNav')
export default function adminNav() {
  return {
    restrict: 'E',
    templateUrl: 'adminNav/admin-nav.tpl.html'
  };
}
