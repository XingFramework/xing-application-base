import { configuration } from '../common/config';

angular.module( configuration.appName + '.navigationBar', [])
.directive('navigationBar',
  function () {
    return {
      restrict: 'E',
      templateUrl: 'navigationBar/navigationBar.tpl.html'
    };
  });
