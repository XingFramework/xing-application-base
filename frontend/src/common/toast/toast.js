import {appName} from '../config';
import {Factory, Controller, Directive, Module} from 'a1atscript';
import {} from './swipe';
import {} from './interimElement';
import Inflector from '../inflector';

/* This is cribbed from the lrd design toast */

@Directive('$lrdToast')
function lrdToastDirective() {
  return {
    restrict: 'E'
  };
}

@Controller('$lrdToastErrorListCtrl', ['$scope','type','header','messages'])
function lrdToastErrorListCtrl($scope, type, header, messages) {
  $scope.type = type;
  $scope.header = header;
  $scope.messages = messages;
}

@Controller('$lrdToastErrorCtrl', ['$scope','type','message'])
function lrdToastErrorCtrl($scope, type, message) {
  $scope.type = type;
  $scope.message = message;
}

@Controller('$lrdToastNoticeCtrl', ['$scope','type','message'])
function lrdToastNoticeCtrl($scope, type, message) {
  $scope.type = type;
  $scope.message = message;
}
/**
 * @ngdoc service
 * @name $lrdToast
 * @module lrd.components.toast
 *
 * @description
 * Open a toast notification on any position on the screen, with an optional
 * duration.
 *
 * Only one toast notification may ever be active at any time. If a new toast is
 * shown while a different toast is active, the old toast will be automatically
 * hidden.
 *
 * `$lrdToast` is an `$interimElement` service and adheres to the same behaviors.
 *  - `$lrdToast.show()`
 *  - `$lrdToast.hide()`
 *  - `$lrdToast.cancel()`
 *
 * @usage
 * <hljs lang="html">
 * <div ng-controller="MyController">
 *   <lrd-button ng-click="openToast()">
 *     Open a Toast!
 *   </lrd-button>
 * </div>
 * </hljs>
 * <hljs lang="js">
 * var app = angular.module('app', ['nglrd']);
 * app.controller('MyController', function($scope, $lrdToast) {
 *   $scope.openToast = function($event) {
 *     $lrdToast.show({
 *       template: '<lrd-toast>Hello!</lrd-toast>',
 *       hideDelay: 3000
 *     });
 *   };
 * });
 * </hljs>
 */

 /**
 * @ngdoc method
 * @name $lrdToast#show
 *
 * @description
 * Show a toast dialog with the specified options.
 *
 * @paramType Options
 * @param {string=} templateUrl The url of an html template file that will
 * be used as the content of the toast. Restrictions: the template must
 * have an outer `lrd-toast` element.
 * @param {string=} template Same as templateUrl, except this is an actual
 * template string.
 * @param {number=} hideDelay How many milliseconds the toast should stay
 * active before automatically closing.  Set to 0 to disable duration.
 * Default: 3000.
 * @param {string=} position Where to place the toast. Available: any combination
 * of 'bottom', 'left', 'top', 'right', 'fit'. Default: 'bottom left'.
 * @param {string=} controller The controller to associate with this toast.
 * The controller will be injected the local `$hideToast`, which is a function
 * used to hide the toast.
 * @param {string=} locals An object containing key/value pairs. The keys will
 * be used as names of values to inject into the controller. For example,
 * `locals: {three: 3}` would inject `three` into the controller with the value
 * of 3.
 * @param {object=} resolve Similar to locals, except it takes promises as values
 * and the toast will not open until the promises resolve.
 * @param {string=} controllerAs An alias to assign the controller to on the scope.
 *
 * @returns {Promise} Returns a promise that will be resolved or rejected when
 *  `$lrdToast.hide()` or `$lrdToast.cancel()` is called respectively.
 */

/**
 * @ngdoc method
 * @name $lrdToast#hide
 *
 * @description
 * Hide an existing toast and `resolve` the promise returned from `$lrdToast.show()`.
 *
 * @param {*} arg An argument to resolve the promise with.
 *
 */

/**
 * @ngdoc method
 * @name $lrdToast#cancel
 *
 * @description
 * Hide an existing toast and `reject` the promise returned from `$lrdToast.show()`.
 *
 * @param {*} arg An argument to reject the promise with.
 *
 */

@Factory('$lrdToast', ['$timeout','$$interimElement','$animate','$lrdSwipe','Inflector'])
function lrdToastService($timeout, $$interimElement, $animate, $lrdSwipe, Inflector) {

  var factoryDef = {
    onShow: onShow,
    onRemove: onRemove,
    position: 'bottom left',
    hideDelay: 3000,
  };

  var toastElement = angular.element(document.getElementById("toast_main"));
  var $lrdToast = $$interimElement(factoryDef);

  $lrdToast.notice = function(message, type = "notice") {
    return this.show({
      parent: toastElement,
      templateUrl: "toast/notice.tpl.html",
      position: 'top left',
      locals: {
        type: type,
        message: message
      },
      controller: '$lrdToastNoticeCtrl'
    });
  };

  $lrdToast.error = function(message, type = "error") {
    return this.show({
      parent: toastElement,
      templateUrl: "toast/error.tpl.html",
      position: 'top left',
      locals: {
        type: type,
        message: message
      },
      controller: '$lrdToastErrorCtrl'
    });
  };

  $lrdToast.errorList = function(errors, header = "", type = "error") {
    var messages = [];
    if (Array.isArray(errors)) {
      messages = errors;
    } else {
      for (var key in errors) {
        if (errors.hasOwnProperty(key)) {
          messages.push(`${Inflector.humanize(key)} ${errors[key]}`);
        }
      }
    }
    return this.show({
      parent: toastElement,
      templateUrl: "toast/error-list.tpl.html",
      position: 'top left',
      locals: {
        type: type,
        header: header,
        messages: messages
      },
      controller: '$lrdToastErrorListCtrl'

    });
  };

  return $lrdToast;

  function onShow(scope, element, options) {
    element.addClass(options.position);
    options.parent.addClass(toastOpenClass(options.position));

    var configureSwipe = $lrdSwipe(scope, 'swipeleft swiperight');
    options.detachSwipe = configureSwipe(element, function(ev) {
      //Add swipeleft/swiperight class to element so it can animate correctly
      element.addClass(ev.type);
      $timeout($lrdToast.hide);
    });

    return $animate.enter(element, options.parent);
  }

  function onRemove(scope, element, options) {
    options.detachSwipe();
    options.parent.removeClass(toastOpenClass(options.position));
    return $animate.leave(element);
  }

  function toastOpenClass(position) {
    return 'lrd-toast-open-' +
      (position.indexOf('top') > -1 ? 'top' : 'bottom');
  }
}

var Toast = new Module('toast', [
  `${appName}.interimElement`,
  `${appName}.swipe`,
  Inflector,
  lrdToastDirective,
  lrdToastErrorListCtrl,
  lrdToastErrorCtrl,
  lrdToastNoticeCtrl,
  lrdToastService
]);

export default Toast;
