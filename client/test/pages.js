import {configuration} from '../src/common/config';
import {} from '../src/app/pages/pages';
import {} from 'test/json-fixtures/pages/one.json';

describe( 'Pages section', function() {

  beforeEach( module( `${configuration.appName}.pages` ) );
  beforeEach( module( `${configuration.appName}.server` ) );
  beforeEach( module( 'fixtureCache' ) );

  describe('Pages Controller', function () {

    var PageMock, pageJson, pageObject, $stateParamsMock, q, pagesCtrl, oneSpy, emitSpy, metadata, $sceMock;

    beforeEach(function() {
      inject(function($templateCache) {
        var pageJson = $templateCache.get('json-fixtures/pages/one.json');
        pageObject = angular.fromJson(pageJson);
      });
      PageMock = {
        one: function(item) {
          return {
            page: function() {
              return {
                content: 'super duper awesome '+item,
                title: 'awesome-'+item,
                metadata: "metadata",
                keywords: 'keyword-'+item,
                description: 'description-'+item
              };
            },
            get: function() {
              var deferred = q.defer();
              deferred.resolve(this.page());
              return deferred.promise;
            }
          };
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

      oneSpy = spyOn(PageMock, 'one');
      oneSpy.and.callThrough();

      inject(function($controller, $rootScope, $q) {
        q = $q;
        this.scope = $rootScope.$new();
        emitSpy = spyOn(this.scope, '$emit');
        pagesCtrl = $controller('PagesCtrl', {
          $scope: this.scope,
          $stateParams: $stateParamsMock,
          Page: PageMock,
          $sce: $sceMock
        });
        this.scope.$apply();
      });

    });

    it('should query the server', function() {
      expect(oneSpy).toHaveBeenCalledWith('dude');
    });

    it('should assign the page', function() {
      expect(this.scope.page).toBe(pageObject.contents);
    });

    it('should emit the metadata', function() {
      expect(emitSpy).toHaveBeenCalledWith('metadataSet', metadata);
    });
  });
});
