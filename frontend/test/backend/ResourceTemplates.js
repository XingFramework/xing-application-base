import templates from "../../src/common/backend/ResourceTemplates";

describe('ResourceTemplates function', function() {

  function responseData() {
    return {
      // links: {},
      data: {
      },
      links: {
        "page": "/pages/{url_slug}",
        "menu": "/menu/{id}"
      }
    };
  }

  var mockBackend, resourceTemplates, resourceTemplatesCopy;

  beforeEach(function() {
    var promise = new Promise(function(resolve){
      var data = responseData();
      return resolve(data);
    });
    mockBackend = {
      load(ResourceClass, url, responseFn = null) {
        console.log("called!");
        return new ResourceClass(this, promise);
      }
    };
    spyOn(mockBackend, 'load').and.callThrough();

  });

  describe("on first visit to page", function() {

    beforeEach(function(done) {
      window.localStorage.removeItem("resourceTemplates");
      templates.fetchedTemplates = null;
      templates.remotePromise = null;
      templates.get(mockBackend).then(function(results){
        resourceTemplates = results;
        done();
      });
    });

    it('should have the right result', function() {
      expect(resourceTemplates["page"].toString()).toEqual("/pages/{url_slug}");
      expect(resourceTemplates["menu"].toString()).toEqual("/menu/{id}");
    });

    it('send .load to backend', function() {
      expect(mockBackend.load).toHaveBeenCalled();
    });

    it('should save to localStorage', function() {
      expect(window.localStorage.getItem("resourceTemplates")).toEqual(JSON.stringify(responseData()));
    });

    describe("on later calls", function() {
      beforeEach(function(done) {
        resourceTemplates = templates.get(mockBackend);
        resourceTemplates.then(function(results) {
          resourceTemplates = results;
          done();
        });
      });

      it("should not make another call to the backend", function() {
        expect(mockBackend.load.calls.count()).toEqual(1);
      });
    });

  });

  describe("while backend call is happening", function() {

    beforeEach(function(done) {
      window.localStorage.removeItem("resourceTemplates");
      templates.fetchedTemplates = null;
      templates.remotePromise = null;
      var firstCall = templates.get(mockBackend);
      var secondCall = templates.get(mockBackend);
      firstCall.then(function(results) {
        resourceTemplates = results;
        secondCall.then(function(secondResults) {
          resourceTemplatesCopy = secondResults;
          done();
        });
      });

    });

    it('should have the right results', function() {
      expect(resourceTemplates["page"].toString()).toEqual("/pages/{url_slug}");
      expect(resourceTemplates["menu"].toString()).toEqual("/menu/{id}");
      expect(resourceTemplatesCopy["page"].toString()).toEqual("/pages/{url_slug}");
      expect(resourceTemplatesCopy["menu"].toString()).toEqual("/menu/{id}");

    });

    it('send .load to backend only once', function() {
      expect(mockBackend.load.calls.count()).toEqual(1);
    });

    it('should save to localStorage', function() {
      expect(window.localStorage.getItem("resourceTemplates")).toEqual(JSON.stringify(responseData()));
    });


  });

  describe("on return to page", function() {
    beforeEach(function(done) {
      window.localStorage.setItem("resourceTemplates", JSON.stringify({
        data: {
        },
        links: {
          "cheese": "/cheese/{url_slug}"
        }
      }));
      templates.fetchedTemplates = null;
      templates.remotePromise = null;
      templates.get(mockBackend).then(function(results) {
        resourceTemplates = results;
        done();
      });
    });

    it('should have the result from local storage', function() {
      expect(resourceTemplates["cheese"].toString()).toEqual("/cheese/{url_slug}");
    });

    it('send .load to backend', function() {
      expect(mockBackend.load).toHaveBeenCalled();
    });

  });

});
