import {Homepage} from "../../src/common/server/homepage";

describe('Homepage class', function() {
  var page;

  function responseData() {
    return {
      // links: {},
      data: {
        title: "Title 1",
        keywords: "keyword1 keyword2",
        description: "Description 1",
        layout:  "one_column",
        contents: { }
      }
    };
  }

  beforeEach(function(done) {
    var promise = new Promise(function(resolve){
      var data = responseData();
      return resolve(data);
    });
    page = new Homepage(promise);
    page.responsePromise.then(function(){
      done();
    });
  });

  it('should have a layout', function() {
    expect(page.layout).toEqual('one_column');
  });

  it('should wrap metadata', function(){
    expect(page.metadata).toBeInstanceOf(Object);
  });

  it('should have a title', function() {
    expect(page.metadata.title).toEqual('Title 1');
  });

  it('should have keywords', function() {
    expect(page.metadata.keywords).toEqual('keyword1 keyword2');
  });

  it('should have a description', function() {
    expect(page.metadata.description).toEqual('Description 1');
  });


});
