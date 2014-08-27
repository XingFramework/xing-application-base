describe( 'Pages section', function() {
  beforeEach( module( 'LRNewWebsite.pages' ) );

  describe ('Pages service', function() {
    var restangularMock, restangularSpy, Pages;
    beforeEach(function() {
      restangularMock = {
        restangularServices: {},
        service: function(serviceName) {
          console.log('called');
          this.restangularServices[serviceName] = {
            getList: jasmine.createSpy()
          };
          return this.restangularServices[serviceName];
        }
      };

      restangularSpy = spyOn(restangularMock, 'service');

      restangularSpy.and.callThrough();

      module(function($provide) {
        $provide.value('Restangular', restangularMock);
      });

      inject(function ($injector) {
        Pages = $injector.get('Pages');
      });

    });

    it('should create a restangular service', function() {
      expect(Pages).toBe(restangularMock.restangularServices['pages']);
      expect(restangularSpy).toHaveBeenCalled();
    });

    it('should behave like a restangular service', function() {
      Pages.getList();
      expect(restangularMock.restangularServices['pages'].getList).toHaveBeenCalled();
    });
  });

  describe('Pages Controller', function () {
    var PagesMock, $stateParamsMock, q, pagesCtrl, oneSpy, emitSpy, metadata;

    beforeEach(function() {
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
                css: 'div.'+item+' { display: block; }',
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

      oneSpy = spyOn(PagesMock, 'one');
      oneSpy.and.callThrough();

      inject(function($controller, $rootScope, $q) {
        q = $q;
        this.scope = $rootScope.$new();
        emitSpy = spyOn(this.scope, '$emit');
        pagesCtrl = $controller('PagesCtrl', {
          $scope: this.scope,
          $stateParams: $stateParamsMock,
          Pages: PagesMock
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
