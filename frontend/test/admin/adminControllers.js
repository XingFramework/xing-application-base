import {} from '../../src/app/admin/adminControllers.js';
import {appName} from 'config';
import {AdminMenusCtrl} from "../../src/app/admin/adminControllers.js";

describe('Admin Controllers', function() {
  var controller, $scope, $state, stateSpy, menuList;
  beforeEach(function() {
    $state = {
      go() {}
    };
    stateSpy = spyOn($state, "go");
  });

  describe('AdminMenusCtrl', function() {
    beforeEach(function() {
      $scope = {};
      menuList = { menus: ["Some", "Menus"] };

      controller = new AdminMenusCtrl($scope, $state, menuList);
    });

    it('should set up the scope', function() {
      expect($scope.menus).toEqual(menuList.menus);
    });

    it('should set up the newMenu action', function() {
      $scope.newMenu();
      expect(stateSpy).toHaveBeenCalledWith('^.menu.new');
    });
  });
});
