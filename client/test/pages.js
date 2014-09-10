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
      });

      metadata = {};

      BackendMock = {
        page(permalink) {
          var promise;
          promise = new Promise(function(resolve){
            return resolve(Page);
          });
          Page.responsePromise = promise;
          return Page;
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

    // verify testing of sce
    it('should return content as escaped html', function(){
      Page.responsePromise.then((response) => {
        expect(this.scope.content).toBe("Four score and <em>seven</em> years");
        done();
      });
    });

    // verify testing of sce
    it('should return styles as escaped css', function(){
      Page.responsePromise.then((response) => {
        expect(this.scope.metadata.styles).toBe("p { font-weight: bold; }");
        done();
      });
    });

    it('should emit the metadata', function() {
      Page.responsePromise.then((response) => {
        expect(emitSpy).toHaveBeenCalledWith('metadataSet', metadata);
        done();
      });
    });
  });
});
