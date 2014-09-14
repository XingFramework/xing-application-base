import { configuration } from '../../common/config';
import {} from '../../../vendor/angular-cookies/angular-cookies';
import {} from '../../../vendor/ng-token-auth/ng-token-auth';

angular.module( configuration.appName + '.admin', [`${configuration.appName}.config`, 'ng-token-auth'])
.directive('adminOnly',
  ['$rootScope', '$auth', function ($rootScope, $auth) {
    function link(scope, element, attrs) {
      scope.showAdmin = false;
      $auth.validateUser().then((user) => {
        scope.showAdmin = true;
      });
      $rootScope.$on('auth:login-success', (ev, user) => {
        scope.showAdmin = true;
      });
      $rootScope.$on('auth:logout-success', (ev, user) => {
        scope.showAdmin = false;
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
