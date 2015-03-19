import {} from '../../src/app/admin/adminControllers.js';
import {appName} from 'config';

describe('Admin Controllers', function() {
  describe('AdminMenusCtrl', function() {
    var $scope, $state, menuList;

    beforeEach(function() {
      module(`${appName}.admin`);

      $scope = {};
      $state = jasmine.createSpyObj('$state', ["go", "get"]);
      $state.get.and.returnValue([]);
      menuList = { menus: ["Some", "Menus"] };

      inject(function($controller){
        /* jshint -W075 */
        $controller('AdminMenusCtrl', { $scope, $state, menuList });
      });
    });

    it('should set up the scope', function() {
      expect($scope.menus).toEqual(menuList.menus);
    });

    it('should set up the newMenu action', function() {
      $scope.newMenu();
      expect($state.go).toHaveBeenCalledWith('^.menu.new');
    });

  });

});
