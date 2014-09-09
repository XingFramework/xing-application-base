import '../vendor/angular/angular';
import '../vendor/angular-mocks/angular-mocks';
import '../src/app/navigationBar/navigationBar';

describe('navigationBar directive', function() {
  var $compile, $rootScope;

  function compiledWithMenu(menu){
    $rootScope.mainMenu = menu;
    var element = $compile("<lrd-navbar id='main-nav' menu='mainMenu' />")($rootScope);
    $rootScope.$digest();

    return element;
  }

  function xpath(context, expr, resType){
    if(!resType) { resType = XPathResult.ORDERED_NODE_SNAPSHOT_TYPE; }
    var result = document.evaluate(expr, context[0], null, resType, null);
    return result;
  }

  function stringAtXpath(context, expr){
    return xpath(context, expr, XPathResult.STRING_TYPE).stringValue;
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
      element = compiledWithMenu([ {
        name: "Test Page",
        target: "/pages/test-page",
        external: function(){ return false; },
        internal: function(){ return true; },
        hasChildren: function(){ return false; }
      }]);
    });

    it('should render a UL', function() {
      console.log("test/navigationBar.js:44", "element.html()", element.html());
      expect(element.html()).toContain("ul");
    });

    it('should have a ul with an id like "main-nav"', function() {
      expect(xpath(element, ".//ul[@id='main-nav']").snapshotLength).toBeGreaterThan(0);
    });

    it('have a ui-router state link', function() {
      expect(xpath(element, './/a[@ui-sref="cms.page"]').snapshotLength).toBeGreaterThan(0);
      expect(stringAtXpath(element, './/a[@ui-sref="cms.page"]/@ui-sref-opts')).toMatch(/test-page/);
    });
  });
});
