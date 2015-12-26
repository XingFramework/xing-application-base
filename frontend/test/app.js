import '../src/app/app.js';
import {appName} from 'config';
import {whenGoto} from '../../frontend/src/app/appConfig.js';

describe( 'RootCtrl', function() {
  describe( 'isCurrentUrl', function() {
    var RootCtrl, $location, $scope, mockMain;

    beforeEach( module( appName ) );

    beforeEach( inject( function( $controller, _$location_, $rootScope ) {
      $location = _$location_;
      $scope = $rootScope.$new();
      mockMain = {
        children: {}
      };

      RootCtrl = $controller( 'RootCtrl', { $location: $location, $scope: $scope });
    }));

    it( 'should pass a dummy test', inject( function() {
      expect( RootCtrl ).toBeTruthy();
    }));
  });
});

describe('whenGoto', function() {
  function locSearch(search){
    return {
      search(){
        return search;
      }
    };
  }

  it('should not grab non-matches', function() {
    expect(whenGoto(locSearch({test: "yes"}))).toEqual(false);
  });

  it('should rotate matched query to top', function() {
    expect(whenGoto(locSearch({goto: "place"}))).toEqual("place");
  });

  it('should handle complex search queries', function() {
    expect(whenGoto(locSearch({x:"1", y:"2", goto: "place"}))).toEqual("place?x=1&y=2");
  });
});
