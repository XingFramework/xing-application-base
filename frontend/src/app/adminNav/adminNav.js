import { appName } from '../../common/config';

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
