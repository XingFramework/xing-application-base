describe( 'CmsCtrl', function() {
  describe( 'isCurrentUrl', function() {
    var CmsCtrl, $location, $scope, mockMain;

    beforeEach( module( 'Reasoning' ) );

    beforeEach( inject( function( $controller, _$location_, $rootScope ) {
      $location = _$location_;
      $scope = $rootScope.$new();
      mockMain = {};

      CmsCtrl = $controller( 'CmsCtrl', { $location: $location, $scope: $scope, mainMenu: mockMain });
    }));

    it( 'should pass a dummy test', inject( function() {
      expect( CmsCtrl ).toBeTruthy();
    }));

    it('should assign the menu into the scope', function() {
      expect( $scope.mainMenu ).toEqual(mockMain);
    });
  });
});
