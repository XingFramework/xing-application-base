import {Directive} from 'a1atscript';

@Directive('adminNav', [])
export default function adminNav() {
  return {
    restrict: 'E',
    templateUrl: 'adminNav/admin-nav.tpl.html'
  };
}
