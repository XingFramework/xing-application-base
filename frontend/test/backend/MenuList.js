import MenuList from "../../src/common/resources/MenuList";
import mockResourceTemplates from "../support/mockResourceTemplates";

describe('MenuList class', function() {
  describe('created in the client', function() {
    var menuList, mockBackend;

    beforeEach(function() {
      mockBackend = {};
      mockResourceTemplates();
      menuList = new MenuList(mockBackend);
    });

    it('should have defined values on all getters', function() {
      expect(menuList.menus).toEqual([]);
    });
  });

  describe('with a live result', function() {

    var menuList;

    function responseData() {
      return {
        links: {},
        data: [ {
            links: { self: "/admin/menus/1" },
            data: { name: "I am Sam" }
          } ]
      };
    }

    var mockBackend;

    beforeEach(function(done) {
      var promise = new Promise(function(resolve){
        var data = responseData();
        return resolve(data);
      });
      mockBackend = {};
      mockResourceTemplates();
      menuList = new MenuList(mockBackend);
      menuList.backendResponds(promise);
      menuList.complete.then((list) => {
        done();
        return list;
      }, (error) => {
        console.error(error);
        console.log(error.stack);
        done();
      });
    });

    it('should have a name for first child', function() {
      expect(menuList.menus[0].name).toEqual("I am Sam");
    });

    it('should have a url for the first child', function() {
      expect(menuList.menus[0].url).toEqual("/admin/menus/1");
    });
  });
});
