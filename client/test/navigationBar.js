import '../vendor/angular/angular';
import '../vendor/angular-mocks/angular-mocks';
import '../src/app/navigationBar/navigationBar';
import {xpath, stringAtXpath} from "../test-help/xpath";


describe('navigationBar directive', function() {
  var $compile, $rootScope;

  function compiledWithMenu(menu){
    $rootScope.mainMenu = menu;
    menu.complete = { then: (cb) => { cb(); } };
    var element = $compile("<lrd-navbar id='main-nav' menu='mainMenu' />")($rootScope);
    $rootScope.$digest();

    return element;
  }

  beforeEach(module('Reasoning.navigationBar'));

  beforeEach(inject(function(_$compile_, _$rootScope_){
    $compile = _$compile_;
    $rootScope = _$rootScope_;
  }));

  describe('with an empty menu', function() {
    it('should render as empty', function() {
      var element = compiledWithMenu({});
      expect(element.html()).not.toContain("ul");
    });
  });

  describe('with a menu with a single item', function() {
    var element;

    beforeEach(function() {
      element = compiledWithMenu({ items: [ {
        name: "Test Page",
        target: "/pages/test-page",
        external: function(){ return false; },
        internal: function(){ return true; },
        hasChildren: function(){ return false; }
      }] });
    });

    it('should render a UL', function() {
      expect(element.html()).toContain("ul");
    });

    it('should have a ul with an id like "main-nav"', function() {
      expect(xpath(element, ".//ul[@id='main-nav']").snapshotLength).toBeGreaterThan(0);
    });

    xit('have a ui-router state link', function() {
      expect(xpath(element, './/a[@ui-sref]').snapshotLength).toBeGreaterThan(0);
      //expect(stringAtXpath(element, './/a[@ui-sref]/@ui-sref')).toMatch(/test-page/);
    });
  });
});
