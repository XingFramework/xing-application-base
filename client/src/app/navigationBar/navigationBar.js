import { configuration } from '../../common/config';

angular.module( `${configuration.appName}.navigationBar`, [])
.directive('lrdNavbar',
  function () {
    return {
      restrict: 'E',
      templateUrl: 'navigationBar/navigationBar.tpl.html',
      scope: {
        id: "=?",
        menu: "=",
        subMenu: "=?"
      }
    };
  });
