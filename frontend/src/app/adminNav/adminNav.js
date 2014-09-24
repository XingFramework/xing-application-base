import { appName } from '../../common/config';
import {} from '../../../vendor/angular-cookies/angular-cookies';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';

angular.module(`${appName}.adminNav`, [`${appName}.config`, 'ng-token-auth'])

.directive('adminNav',
  function($auth, $state) {
    function link(scope, element, attrs) {
      scope.logout = () => {
        $auth.signOut().then((response) => {
          $state.go('root.homepage.show');
        });
      };
    }
    return {
      link: link,
      restrict: 'E',
      templateUrl: 'adminNav/admin-nav.tpl.html'
    };
  });
