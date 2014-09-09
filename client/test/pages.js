describe( 'Pages section', function() {
  beforeEach( module( 'Reasoning.pages' ) );
  beforeEach( module( 'Reasoning.server' ) );
  beforeEach( module( 'fixtureCache' ) );

  describe('Pages Controller', function () {

    var PagesMock, pageJson, pageObject, $stateParamsMock, q, pagesCtrl, oneSpy, emitSpy, metadata, $sceMock;

    beforeEach(function() {
      inject(function($templateCache) {
        var pageJson = $templateCache.get('json-fixtures/pages/one.json');
        pageObject = angular.fromJson(pageJson);
      });
      metadata = {
        pageTitle: 'awesome-dude',
        pageCss: 'div.dude { display: block; }',
        pageKeywords: 'keyword-dude',
        pageDescription: 'description-dude'
      };
      PagesMock = {
        one: function(item) {
          return {
            page: function() {
              return {
                content: 'super duper awesome '+item,
                title: 'awesome-'+item,
                styles: 'div.'+item+' { display: block; }',
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
      console.log(PagesMock);

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
      expect(this.scope.contents).toBe(pageObject.contents);
    });

    it('should assign the metadata', function() {
      expect(emitSpy).toHaveBeenCalledWith('metadataSet', metadata);
    });
  });
});
