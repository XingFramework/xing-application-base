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

      BackendMock = {
        page(permalink) {
          Page.then = (resolve) => {
            resolve();
          };
          return Page;
        }
      };

      $stateParamsMock = {
        permalink: 'dude'
      };

      $sceMock = {
        trustAsHtml(data) {
          return data;
        }
      };

      pageSpy = spyOn(BackendMock, 'page');
      pageSpy.and.callThrough();

      inject(function($controller, $rootScope) {
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

    it('should assign headline', function(){
      expect(this.scope.headline).toBe("The Gettysburg Address");
    });

    it('should assign content', function(){
      expect(this.scope.content).toBe("Four score and <em>seven</em> years");
    });

    xit('should trust content as html', function() {
      expect(this.scope.content).toBe("");
    });

    it('should assign the metadata', function() {
      expect(this.scope.metadata instanceof Object).toBeTruthy();
      expect(this.scope.metadata).toBe(Page.metadata);
    });

    it('should emit the metadata', function() {
      expect(emitSpy).toHaveBeenCalledWith('metadataSet', Page.metadata);
    });
  });
});
