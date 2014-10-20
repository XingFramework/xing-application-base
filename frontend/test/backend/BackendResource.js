import {BackendResource} from "../../src/common/backend/BackendResource";
import mockResourceTemplates from "../support/mockResourceTemplates";

class TestResource extends BackendResource {
  get resourceName() {
    return "test";
  }

  paramsFromShortLink(shortLink) {
    return {tool: shortLink};
  }
}

class OtherTestResource extends BackendResource {
  get resourceName() {
    return "otherTest";
  }

  shortLinkFromParams(params) {
    return params["cheese"]+"_"+params["ball"];
  }

  paramsFromShortLink(shortLink) {
    var parts = shortLink.split("_");
    return {cheese: parts[0], ball: parts[1]};
  }
}
OtherTestResource.prototype.defineJsonProperty('testUrl', "$.links.test");
OtherTestResource.prototype.defineRelatedShortLink(TestResource, 'test', 'testUrl');

describe("Backend Resource", function() {
  var test, otherTest, mockBackend;

  function responseData() {
    return {
      data: {},
      links: {
        self: "/test/grater"
      }
    };
  }

  function otherResponseData() {
    return {
      data: {},
      links: {
        self: "/other_test/gouda/spiky",
        test: "/test/hammer"
      }
    };
  }

  function loadFromResponseData() {
    return {
      data: {

      },
      links: {
        self: "/test/drill"
      }
    };
  }


  function uriTemplates() {
    return {
      "test": new UriTemplate("/test/{tool}"),
      "otherTest": new UriTemplate("/other_test/{cheese}/{ball}")
    };
  }

  describe("properties", function() {

    beforeEach(function(done) {
      var dataPromise = new Promise(function(resolve){
        var data = responseData();
        return resolve(data);
      });
      var otherDataPromise = new Promise(function(resolve){
        var data = otherResponseData();
        return resolve(data);
      });
      mockResourceTemplates(uriTemplates());
      mockBackend = {};
      test = new TestResource(mockBackend, dataPromise);
      test.complete.then(function(){
        otherTest = new OtherTestResource(mockBackend, otherDataPromise);
        return otherTest.complete;
      }).then(function() {
        done();
        return;
      });
    });


    it("should set shortLinks", function() {
      expect(test.shortLink).toEqual("grater");
      expect(otherTest.shortLink).toEqual("gouda_spiky");
    });

    it("should translate shortLink to Url", function() {
      expect(test.urlFromShortLink("knife")).toEqual("/test/knife");
      expect(otherTest.urlFromShortLink("feta_moldy")).toEqual("/other_test/feta/moldy");
    });


    it("should load be able to get related short links", function() {
      expect(otherTest.test).toEqual("hammer");
    });

  });

  describe("loadFromShortLink", function() {

    beforeEach(function(done) {

      var dataPromise = new Promise(function(resolve){
        var data = loadFromResponseData();
        return resolve(data);
      });

      mockResourceTemplates(uriTemplates());

      mockBackend = {
        loadTo(url, resource) {
          test.backendResponds(dataPromise);
        }
      };

      spyOn(mockBackend, 'loadTo').and.callThrough();
      test = new TestResource(mockBackend);
      test.loadFromShortLink("drill");

      test.complete.then(function() {
        done();
        return;
      });
    });

    it("should load from the correct url", function() {
      expect(mockBackend.loadTo).toHaveBeenCalledWith("/test/drill", test);
    });

    it("should finish the load and set values on the object, including short link", function() {
      expect(test.selfUrl).toEqual("/test/drill");
      expect(test.shortLink).toEqual("drill");
    });
  });
});