import {} from '../../src/app/admin/adminStates';
import setupLogging from "ui-route-logger";
import {appName} from 'config';

xdescribe('adminStates', function() {
  describe('root.admin.menus', function() {
    var mockBackend, mockMenuList;
    var $rootScope, $state;
    var mockScope;
    var stateName = "root.admin.menus";

    beforeEach(function() {
      mockMenuList = { };
      mockMenuList.complete = mockMenuList;
      mockBackend = { menuList(){
        console.log("mBmL");
        return mockMenuList; }};
      mockScope = {};
      module('ui.router.state', ($provide, $stateProvider) => {
        $provide.constant('backend', mockBackend);
        $provide.constant('$auth', {
          validateUser(){
            console.log("here");
            return true;
          },
          initialize(){},
          config: {}
        });
        $stateProvider.state('root', {url: "/", template: "<ui-view></ui-view>"});
      }, `${appName}.admin`);

      inject((_$rootScope_, _$state_, $httpBackend) => {
        $httpBackend.when("GET", "admin/admin.tpl.html").respond("<ui-view></ui-view>");
        $httpBackend.when("GET", "admin/menus.tpl.html").respond("<ui-view></ui-view>");
        $rootScope = _$rootScope_;
        $state = _$state_;
        setupLogging($rootScope, $state, true);
      });
    });

    // Never arrives at the state being tested, never raises an error. Dunno.
    it('set up the menuList', inject(function($injector) {
      $state.go(stateName);
      $rootScope.$digest();

      expect($state.current.name).toBe(stateName);
      expect($injector.invoke($state.current.resolve.menuList)).toBe(mockMenuList);
    }));
  });
});
