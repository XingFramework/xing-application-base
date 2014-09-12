import {configuration} from '../src/common/config';
import {} from '../src/app/pages/pages';
import {} from 'test/json-fixtures/pages/client.json';
import {Page} from '../src/common/server/page';

ddescribe( 'Pages section', function() {

  beforeEach( module( `${configuration.appName}.pages` ) );
  beforeEach( module( `${configuration.appName}.server` ) );
  beforeEach( module( 'fixtureCache' ) );

  var $scope, $stateMock, pagesCtrl, pageSpy, emitSpy, $sceMock;

  var page, pageJson, metadata;

  beforeEach( inject(function($templateCache) {
    pageJson = angular.fromJson( $templateCache.get('json-fixtures/pages/server.json'));
  }));

  beforeEach(function(done) {
    var promise = new Promise((resolve, reject) => {
      resolve(pageJson);
    });
    page = new Page(promise);
    page.complete.then((result) => {
      console.log("test/pages.js:26", "page", page);
      done();
    });

  });

  beforeEach(function() {
    $stateMock = {
      go(state){}
    };

    $sceMock = {
      trustAsHtml(data) {
        return data;
      }
    };
  });

  beforeEach( inject(function($controller, $rootScope) {
    $scope = $rootScope.$new();
    emitSpy = spyOn($scope, '$emit');
    pagesCtrl = $controller('PagesCtrl', {
      $scope: $scope,
      $state: $stateMock,
      $sce: $sceMock,
      page: page
    });
    $scope.$apply();
  }));

  it('should assign headline', function(){
    expect($scope.headline).toBe("The Gettysburg Address");
  });

  it('should assign content', function(){
    expect($scope.content.main).toBe("Four score and <em>seven</em> years");
  });

  it('should assign the metadata', function() {
    expect($scope.metadata instanceof Object).toBeTruthy();
    expect($scope.metadata).toBe(Page.metadata);
  });

  it('should emit the metadataSet', function() {
    expect(emitSpy).toHaveBeenCalledWith('metadataSet', Page.metadata);
  });

  it('should assign the template', function() {
    expect($scope.template instanceof Object).toBeTruthy();
    expect($scope.template).toBe(Page.template);
  });

  it('should emit the templateSet', function() {
    expect(emitSpy).toHaveBeenCalledWith('templateSet', Page.template);
  });
});
