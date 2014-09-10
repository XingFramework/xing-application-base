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

    it('should return headline', function(){
      Page.responsePromise.then((response) => {
        console.log("71");
        expect(this.scope.headline).toBe("The Gettysburg Address");
        console.log("72");
        done();
      });
    });

    it('should return content as escaped html', function(){
      Page.responsePromise.then((response) => {
        console.log("76");
        expect(this.scope.content.$$unwrapTrustedValue()).toBe("Four score and <em>seven</em> years");
        console.log("80");
        done();
      });
    });

    it('should return styles as escaped css', function(){
      Page.responsePromise.then((response) => {
        console.log("87");
        expect(this.metadata.pageStyles.$$unwrapTrustedValue()).toBe("p { font-weight: bold; }");
        console.log("89");
        done();
      });
    });

    it('should emit the metadata', function() {
      Page.responsePromise.then((response) => {
        console.log("96");
        expect(emitSpy).toHaveBeenCalledWith('metadataSet', this.page.metadata);
        console.log("98");
        done();
      });
    });
  });
});
