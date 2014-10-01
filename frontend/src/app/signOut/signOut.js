import { appName } from '../../common/config';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';

angular.module( `${appName}.signOutDirective`, [`${appName}.config`,
  'ng-token-auth',
  'ui.router.state'])
.directive('lrdSignOut',
  ['$state', '$auth', function ($state, $auth) {
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
  }]);
