import {appName} from "../../src/common/config";
import {} from "../../src/common/toast/toast";

describe('$lrdToast service', function() {
  beforeEach(module(`${appName}.toast`, 'ngAnimateMock', function($provide) {
  }));

  function setup(options) {
    inject(function($lrdToast, $rootScope, $animate) {
      options = options || {};
      $lrdToast.show(options);
      $rootScope.$apply();
      $animate.triggerCallbacks();
    });
  }

  describe('options', function() {

    it('should hide after duration', inject(function($timeout, $animate, $rootElement) {
      var parent = angular.element('<div>');
      setup({
        template: '<lrd-toast />',
        hideTimeout: 1234
      });
      expect($rootElement.find('lrd-toast').length).toBe(1);
      $timeout.flush();
      expect($rootElement.find('lrd-toast').length).toBe(0);
    }));

    it('should have template', inject(function($timeout, $rootScope, $rootElement) {
      var parent = angular.element('<div>');
      setup({
        template: '<lrd-toast>{{1}}234</lrd-toast>',
        appendTo: parent
      });
      var toast = $rootElement.find('lrd-toast');
      $timeout.flush();
      expect(toast.text()).toBe('1234');
    }));

    it('should have templateUrl', inject(function($timeout, $rootScope, $templateCache, $rootElement) {
      $templateCache.put('template.html', '<lrd-toast>hello, {{1}}</lrd-toast>');
      setup({
        templateUrl: 'template.html',
      });
      var toast = $rootElement.find('lrd-toast');
      expect(toast.text()).toBe('hello, 1');
    }));
  });

  describe('lifecycle', function() {

    it('should hide current toast when showing new one', inject(function($rootElement) {
      setup({
        template: '<lrd-toast class="one">'
      });
      expect($rootElement.find('lrd-toast.one').length).toBe(1);
      expect($rootElement.find('lrd-toast.two').length).toBe(0);
      expect($rootElement.find('lrd-toast.three').length).toBe(0);

      setup({
        template: '<lrd-toast class="two">'
      });
      expect($rootElement.find('lrd-toast.one').length).toBe(0);
      expect($rootElement.find('lrd-toast.two').length).toBe(1);
      expect($rootElement.find('lrd-toast.three').length).toBe(0);

      setup({
        template: '<lrd-toast class="three">'
      });
      expect($rootElement.find('lrd-toast.one').length).toBe(0);
      expect($rootElement.find('lrd-toast.two').length).toBe(0);
      expect($rootElement.find('lrd-toast.three').length).toBe(1);
    }));

    it('should add class to toastParent', inject(function($rootElement) {
      setup({
        template: '<lrd-toast>'
      });
      expect($rootElement.hasClass('lrd-toast-open-bottom')).toBe(true);

      setup({
        template: '<lrd-toast>',
        position: 'top'
      });
      expect($rootElement.hasClass('lrd-toast-open-top')).toBe(true);
    }));

  });
});