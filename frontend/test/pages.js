import {configuration} from '../src/common/config';
import {} from '../src/app/pages/pages';
import {Page} from '../src/common/resources/Page';
import {} from '../build/test/fixtureCache';

describe( 'Pages section', function() {

  beforeEach( module( `${configuration.appName}.pages` ) );
  beforeEach( module( `${configuration.appName}.backend` ) );
  beforeEach( module( 'fixtureCache' ) );

  var $scope, $stateMock, pagesCtrl, pageSpy, emitSpy, $sceMock;

  var mockBackend;

  var page, pageJson, metadata;

  beforeEach( inject(function($templateCache) {
    pageJson = angular.fromJson( $templateCache.get('json-fixtures/pages/server.json'));
  }));

  beforeEach(function() {
    mockBackend = {};
  });

  beforeEach(function(done) {
    var promise = new Promise((resolve, reject) => {
      resolve(pageJson);
    });
    page = new Page(mockBackend, promise);
    page.completePromise = page.complete.then((result) => {
      done();
      return result;
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
      page: page,
      isAdmin: false
    });
    $scope.$apply();
  }));

  it('should assign headline', function(){
    expect($scope.page.headline).toBe("The Gettysburg Address");
  });

  it('should assign content', function(){
    expect($scope.contentBlocks['main']).toBe("Four score and <em>seven</em> years");
  });

  it('should emit the metadataSet', function() {
    expect(emitSpy).toHaveBeenCalledWith('metadataSet', page.metadata);
  });

  it('should assign the template', function() {
    expect($scope.template).toBe('pages/templates/'+page.layout +".tpl.html");
  });

  it('should set nowEditing to false', function(){
    expect($scope.nowEditing).toBeFalsy();
  });

});
