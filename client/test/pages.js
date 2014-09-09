describe( 'Pages section', function() {
  beforeEach( module( 'Reasoning.pages' ) );
  beforeEach( module( 'Reasoning.server' ) );
  beforeEach( module( 'fixtureCache' ) );

  describe('Pages Controller', function () {
    var PageMock, $stateParamsMock, pageJson, q, pagesCtrl, oneSpy, emitSpy, $sceMock;

    beforeEach(function() {
      pageJson = angular.fromJson($templateCache.get('json-fixtures/pages/one.json'));

      PageMock = {
        one: function(item) {
          return {
            page: function() {
              return {
                headline: 'best ever thing'+item,
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
      expect(this.scope.content).toBe('super duper awesome dude');
    });

    it('should assign the metadata', function() {
      expect(emitSpy).toHaveBeenCalledWith('metadataSet', metadata);
    });
  });
});
