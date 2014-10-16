import {appName} from '../src/common/config';
import '../src/app/stateAttrs/stateAttrs';
import {xpath, stringAtXpath} from "../test-help/xpath";
import {} from "../src/common/ui-route-logger";


describe('lrdStateAttrs directive', function() {
  var $compile, $rootScope, $state;

  beforeEach(module(`${appName}.stateAttrs`, "ui.router.state", function($stateProvider) {
    $stateProvider.state('root', {url: "/", template: "<ui-view lrd-state-attrs label='r' />"});
    $stateProvider.state('root.inner', {url: "/", template: "<ui-view lrd-state-attrs label='r-i' />"});
  }));

  beforeEach(inject(function(_$state_, _$compile_, _$rootScope_){
    $state = _$state_;
    $compile = _$compile_;
    $rootScope = _$rootScope_;
  }));

  describe('in a current state', function() {
    var element;

    beforeEach(function() {
      $state.go('root.inner');
      $rootScope.$apply();
      element = $compile("<ui-view lrd-state-attrs label='t'></ui-view>")($rootScope);
      $rootScope.$digest();
    });

    iit('should have an element with an id like "root_inner"', function() {
      expect(xpath(element, ".//*[@id='root_inner']").snapshotLength).toBeGreaterThan(0);
    });

    it('should have an element with a class like "inner"', function() {
      expect(xpath(element, ".//*[@class='inner']").snapshotLength).toBeGreaterThan(0);
    });
  });
});
