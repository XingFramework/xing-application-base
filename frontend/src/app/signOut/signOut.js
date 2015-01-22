import { appName } from 'config';
import {Module, Directive} from 'a1atscript';

@Module(`${appName}.signOutDirective`, ['ng-token-auth', 'ui.router.state'])
@Directive('lrdSignOut', ['$state', '$auth'])
export default function lrdSignOut($state, $auth) {
  function link(scope, element, attrs) {
    element.on('click',() => {
      $auth.signOut().then((response) => {
        $state.go('root.homepage.show');
      });
    });
  }
  return {
    restrict: 'A',
    link: link
  };
}
