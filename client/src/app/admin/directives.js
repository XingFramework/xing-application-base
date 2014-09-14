import { configuration } from '../../common/config';

angular.module( configuration.appName + '.admin', ['ngCookies', configuration.appName + '.config'])
.directive('adminOnly',
  ['$cookies', function ($cookies) {

    function link(scope, element, attrs) {
      function setShowAdmin(cookieValue) {
        if (cookieValue == '1') {
          scope.showAdmin = true;
        } else {
          scope.showAdmin = false;
        }
      }

      setShowAdmin($cookies.admin);

      scope.$watch($cookies.admin, function(newValue, oldValue) {
        setShowAdmin(newValue);
      });
    }
    return {
      restrict: 'E',
      scope: true,
      link: link,
      transclude: true,
      templateUrl: 'admin/adminOnly.tpl.html'
    };
  }])

.directive('adminNav',
  function() {
    console.log('admin/directives.js:34');
    return {
      restrict: 'E',
      templateUrl: 'admin/adminNav.tpl.html'
    };
  })

.directive('serverLink',
  ['configuration', function(configuration) {
    function link(scope, element, attrs) {
      if (attrs.href) {
        scope.href = configuration.serverUrl + attrs.href;
      } else {
        scope.href = nil;
      }
    }
    return {
      restrict: 'E',
      scope: {
      },
      link: link,
      transclude: true,
      template: '<a href="{{href}}" ng-transclude></a>'
    };
  }])

.directive('serverButton',
  ['configuration', '$sce', function(configuration, $sce) {
    function setup(scope, element, attrs) {
      scope.href="/";
    }
    function link(scope, element, attrs) {
      if (attrs.href) {
        scope.href = $sce.trustAsResourceUrl(configuration.serverUrl + attrs.href);
      } else {
        scope.href = null;
      }
      if (attrs.method) {
        scope.method = attrs.method;
      } else {
        scope.method = null;
      }
      if (attrs.value) {
        scope.value = attrs.value;
      } else {
        scope.value = null;
      }
    }
    return {
      restrict: 'E',
      scope: {},
      link: {
        pre: setup,
        post: link
      },
      templateUrl: 'admin/serverButton.tpl.html'
    };
  }]);
