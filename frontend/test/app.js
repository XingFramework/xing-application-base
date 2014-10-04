import '../vendor/angular/angular';
import '../vendor/angular-mocks/angular-mocks';
import '../src/app/app';

describe( 'RootCtrl', function() {
  describe( 'isCurrentUrl', function() {
    var RootCtrl, $location, $scope, mockMain;

    beforeEach( module( 'LRD-CMS2' ) );

    beforeEach( inject( function( $controller, _$location_, $rootScope ) {
      $location = _$location_;
      $scope = $rootScope.$new();
      mockMain = {
        children: {}
      };

      RootCtrl = $controller( 'RootCtrl', { $location: $location, $scope: $scope, menuRoot: mockMain });
    }));

    it( 'should pass a dummy test', inject( function() {
      expect( RootCtrl ).toBeTruthy();
    }));

    it('should assign the menu into the scope', function() {
      expect( $scope.mainMenu ).toEqual(mockMain.children);
    });
  });
});
