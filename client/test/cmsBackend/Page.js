import {Page} from "../../src/common/server/page";
import {} from 'test/json-fixtures/pages/server.json';

describe('Page class', function() {
  describe('created in the client', function() {
    var page, mockBackend;

    beforeEach(function() {
      mockBackend = {};
      page = new Page(mockBackend);
    });

    it('should have defined values on all getters', function() {
      expect(page.layout).not.toEqual(undefined);
      expect(page.layout).not.toEqual(false);

      expect(page.title).not.toEqual(undefined);
      expect(page.title).not.toEqual(false);

      expect(page.keywords).not.toEqual(undefined);
      expect(page.keywords).not.toEqual(false);

      expect(page.description).not.toEqual(undefined);
      expect(page.description).not.toEqual(false);

      expect(page.styles).not.toEqual(undefined);
      expect(page.styles).not.toEqual(false);

      expect(page.headline).not.toEqual(undefined);
      expect(page.headline).not.toEqual(false);

      expect(page.publishStart).not.toEqual(undefined);
      expect(page.publishStart).not.toEqual(false);

      expect(page.publishEnd).not.toEqual(undefined);
      expect(page.publishEnd).not.toEqual(false);

      expect(page.urlSlug).not.toEqual(undefined);
      expect(page.urlSlug).not.toEqual(false);

      expect(page.metadata).not.toEqual(undefined);
      expect(page.metadata).not.toEqual(false);
    });

    it('set up contents correctly', function() {
      var block;
      page.layout = "two_column";
      page.setupContents();

      block = page.contentBody("headline");
      block.content = "test";
      expect(block.content).toEqual("test");

      block = page.contentBody("styles");
      block.content = "test";
      expect(block.content).toEqual("test");

      block = page.contentBody("columnOne");
      block.content = "test";
      expect(block.content).toEqual("test");

      block = page.contentBody("columnTwo");
      block.content = "test";
      expect(block.content).toEqual("test");
    });
  });


  describe('with a live result', function() {

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

    var mockBackend;

    beforeEach(function(done) {
      var promise = new Promise(function(resolve){
        var data = responseData();
        return resolve(data);
      });
      mockBackend = {};
      page = new Page(mockBackend, promise);
      page.completePromise = page.complete.then(function(){
        done();
      });
    });

    it('should have a title', function() {
      expect(page.title).toEqual('Title 1');
    });

    it('should have a title', function() {
      expect(page.layout).toEqual('one_column');
    });

    it('should have keywords', function() {
      expect(page.keywords).toEqual('keyword1 keyword2');
    });

    it('should have a description', function() {
      expect(page.description).toEqual('Description 1');
    });

    it('should have styles', function(){
      expect(page.styles).toEqual('p { font-weight: bold; }');
    });

    it('should have headline', function(){
      expect(page.headline).toEqual('The Gettysburg Address');
    });

    it('should have mainContent', function() {
      expect(page.mainContent).toEqual('Four score and <em>seven</em> years');
    });

    it('should wrap metadata', function(){
      expect(page.metadata).toBeInstanceOf(Object);
    });

    it('should include appropriate values in metadata object', function(){
      expect(page.metadata.pageTitle).toEqual('Title 1');
      expect(page.metadata.pageKeywords).toEqual('keyword1 keyword2');
      expect(page.metadata.pageDescription).toEqual('Description 1');
      expect(page.metadata.pageStyles).toEqual('p { font-weight: bold; }');
    });

  });
});
