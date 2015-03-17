import 'components/navigationBar';
import {} from 'templates-common';
import {xpath, stringAtXpath} from "../test-help/xpath";
import {appName} from 'config';

describe('navigationBar directive', function() {
  var $compile, $rootScope, $state;

  function compiledWithMenu(menu){
    $rootScope.mainMenu = menu;
    menu.complete = { then: (cb) => { cb(); } };
    var element = $compile("<lrd-navbar id='main-nav' menu='mainMenu' />")($rootScope);
    $rootScope.$digest();

    return element;
  }

  beforeEach(module('LRD-CMS2.navigationBar', 'LRD-CMS2.pages', "ui.router.state", 'templates-common', function($stateProvider) {
    $stateProvider.state('root', {url: "/"});
    $stateProvider.state('root.inner', {url: "/"});
  }));

  beforeEach(inject(function(_$state_, _$compile_, _$rootScope_){
    $state = _$state_;
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
        pageTarget: "test-page",
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


    it('have a ui-router state link', function() {
      var sref = $state.href("root.inner.page.show", {pageUrl: "test-page"});
      expect(xpath(element, `.//a[@href="${sref}"]`).snapshotLength).toBeGreaterThan(0);
      //expect(stringAtXpath(element, './/a[@ui-sref]/@ui-sref')).toMatch(/test-page/);
    });
  });
});
