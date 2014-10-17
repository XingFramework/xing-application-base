import {appName} from '../src/common/config';
import '../src/app/stateAttrs/stateAttrs';
import {xpath, stringAtXpath} from "../test-help/xpath";
import setupUiRouteLogging from "../src/common/ui-route-logger";


describe('lrdStateAttrs directive', function() {
  var $compile, $rootScope, $state;

  beforeEach(module(`${appName}.stateAttrs`, "ui.router.state", function($stateProvider) {
    $stateProvider.state('root', {url: "/", template: "<ui-view label='r' />"});
    $stateProvider.state('root.inner', {url: "/ri", template: "<hr label='r-i' />"});
  }));

  beforeEach(inject(function(_$state_, _$compile_, _$rootScope_){
    $state = _$state_;
    $compile = _$compile_;
    $rootScope = _$rootScope_;
  }));

  describe('in a current state', function() {
    var element;

    beforeEach(function() {
      setupUiRouteLogging($rootScope, $state, true);
      $state.go('root.inner');
      $rootScope.$apply();
      element = $compile("<p>Before</p><ui-view label='t'></ui-view><p>After</p>")($rootScope);
      $rootScope.$digest();
      console.log("test/stateAttrs.js:32", "element", element);
    });

    iit('should have an element with an id like "root" and a class with "root"', function() {
      expect(xpath(element, ".//*[@id='root'][@label='t']").snapshotLength).toBeGreaterThan(0);
      expect(xpath(element, ".//*[@class='root'][@label='t']").snapshotLength).toBeGreaterThan(0);
    });

    iit('should have an element with an id like "root_inner"', function() {
      expect(xpath(element, ".//*[@id='root_inner'][@label='r']").snapshotLength).toBeGreaterThan(0);
      expect(xpath(element, ".//*[@class='inner'][@label='r']").snapshotLength).toBeGreaterThan(0);
    });
  });
});
