import {configuration} from '../src/common/config';
import {} from '../src/app/pages/pages';
import {} from 'test/json-fixtures/pages/client.json';

describe( 'Pages section', function() {

  beforeEach( module( `${configuration.appName}.pages` ) );
  beforeEach( module( `${configuration.appName}.server` ) );
  beforeEach( module( 'fixtureCache' ) );

  describe('Pages Controller', function () {

    var BackendMock, $stateParamsMock, q, pagesCtrl, pageSpy, emitSpy, $sceMock;

    var Page, metadata;

    beforeEach(function() {
      inject(function($templateCache) {
        Page = angular.fromJson(
          $templateCache.get('json-fixtures/pages/client.json')
        );
        console.log(Page);
      });

      metadata = {};

      BackendMock = {
        page(permalink) {
          var promise;
          promise = new Promise(function(resolve){
            return resolve(Page);
          });
          return {responsePromise: promise};
        }
      };

      $stateParamsMock = {
        permalink: 'dude'
      };

      $sceMock = {
        trustAsHtml: function(data) {
          return data;
        }
      };

      pageSpy = spyOn(BackendMock, 'page');
      pageSpy.and.callThrough();

      inject(function($controller, $rootScope, $q) {
        q = $q;
        this.scope = $rootScope.$new();
        emitSpy = spyOn(this.scope, '$emit');
        pagesCtrl = $controller('PagesCtrl', {
          $scope: this.scope,
          $stateParams: $stateParamsMock,
          cmsBackend: BackendMock,
          $sce: $sceMock
        });
        this.scope.$apply();
      });

    });

    it('should query the backend', function() {
      expect(pageSpy).toHaveBeenCalledWith('dude');
    });

    xit('should assign the page', function() {
      expect(this.scope.page).toBeInstanceOf(Page);
    });

    xit('should return content as escaped html', function(){
      expect(this.scope.content).toBe('');
    });

    xit('should return styles as escaped css', function(){
      expect(this.scope.metadata).toBe('');
    });

    xit('should emit the metadata', function() {
      expect(emitSpy).toHaveBeenCalledWith('metadataSet', metadata);
    });
  });
});
