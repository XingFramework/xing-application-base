import {appName} from '../src/common/config';
import '../src/app/stateAttrs/stateAttrs';
import {xpath, stringAtXpath} from "../test-help/xpath";
import setupUiRouteLogging from "../src/common/ui-route-logger";


describe('lrdStateAttrs directive', function() {
  var $compile, $rootScope, $state;

  beforeEach(module(`${appName}.stateAttrs`, "ui.router.state", function($stateProvider) {
    $stateProvider.state('root', {url: "/", template: "<ui-view lrd-state-attrs label='r'></ui-view>"});
    $stateProvider.state('root.inner', {url: "/ri", template: "<hr label='r-i'/>"});
    $stateProvider.state('root.other', {url: "/ro", template: "<hr label='r-o'/>"});
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
      element = $compile("<div ng-app><p>Before</p><ui-view lrd-state-attrs label='t'></ui-view><p>After</p></div>")($rootScope);

      $rootScope.$digest();
    });

    it('should have an element with an id like "root" and a class with "root"', function() {
      expect(xpath(element, ".//*[@label='r-i']").snapshotLength).toBeGreaterThan(0);
      expect(xpath(element, ".//*[@id='root'][@label='t']").snapshotLength).toBeGreaterThan(0);
      expect(xpath(element, ".//*[contains(@class, 'root')][@label='t']").snapshotLength).toBeGreaterThan(0);
    });

    it('should have an element with an id like "root_inner"', function() {
      expect(xpath(element, ".//*[@id='root_inner'][@label='r']").snapshotLength).toBeGreaterThan(0);
      expect(xpath(element, ".//*[contains(@class, 'inner')][@label='r']").snapshotLength).toBeGreaterThan(0);
    });

    it('update attrs when state changes', function() {
      expect(xpath(element, ".//*[@label='r-i']").snapshotLength).toBeGreaterThan(0);

      expect(xpath(element, ".//*[@id='root_other']").snapshotLength).toEqual(0);
      expect(xpath(element, ".//*[contains(@class, 'other')]").snapshotLength).toEqual(0);

      $state.go('root.other');
      $rootScope.$apply();

      expect(xpath(element, ".//*[@label='r-i']").snapshotLength).toEqual(0);
      expect(xpath(element, ".//*[contains(@class, 'inner')]").snapshotLength).toEqual(0);
      expect(xpath(element, ".//*[@id='root_inner']").snapshotLength).toEqual(0);

      expect(xpath(element, ".//*[@id='root_other'][@label='r']").snapshotLength).toBeGreaterThan(0);
      expect(xpath(element, ".//*[contains(@class, 'other')][@label='r']").snapshotLength).toBeGreaterThan(0);
    });
  });
});
