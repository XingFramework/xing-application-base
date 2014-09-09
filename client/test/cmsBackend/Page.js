import {Page} from "../../src/common/server/page";

describe('Page class', function() {
  var page;

  function responseData() {
    return {
      // links: {},
      data: {
        title: "Title 1",
        keywords: "keyword1 keyword2",
        description: "Description 1",
        layout:  "one_column",
        contents: {
          main: {
            links: { self: "/content-blocks/:id"  },
            data: {
              content_type: 'text/html',
              body: 'Four score and <em>seven</em> years'
            }
          },
          headline: {
            links: { self: "/content-blocks/:id" },
            data: {
              content_type: 'text/html',
              body: 'The Gettysburg Address'
            }
          },
          styles: {
            links: { self: "/content-blocks/:id" },
            data: {
              content_type: 'text/css',
              body: 'p { font-weight: bold; }'
            }
          }
        }
      }
    };
  }

  beforeEach(function(done) {
    var promise = new Promise(function(resolve){
      var data = responseData();
      return resolve(data);
    });
    page = new Page(promise);
    page.responsePromise.then(function(){
      done();
    });
  });


  it('should have a layout', function() {
    expect(page.layout).toEqual('one_column');
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

  it('should have styles', function(){
    expect(page.metadata.styles).toEqual('p { font-weight: bold; }');
  });

  it('should have content', function() {
    expect(page.main).toEqual('Four score and <em>seven</em> years');
  });

});
