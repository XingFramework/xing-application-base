angular.module( 'LRNewWebsite.navigationBar', []).directive('navigationBar',
  function () {
    return {
      restrict: 'E',
      templateUrl: 'navigationBar/navigationBar.tpl.html'
    };
  });
