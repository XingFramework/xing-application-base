import {Menu} from "../../src/common/resources/Menu";

describe('Menu class', function() {
  var menu, mockBackend;

  function responseData() {
    return {
      links: {},
      data: [ {
        links: {},
        data: {
          name: 'Test 1',
          type: 'page',
          page: { links: { self: '/pages/test-1'} },
          children: [ {
            links: {},
            data: {
              name: 'Sublevel 1',
              type: 'page',
              page: { links: { self: '/pages/test-2'} },
              children: [
                {
                links: {},
                data: {
                  name: 'Sub-Sublevel 1',
                  type: 'page',
                  page: { links: { self: '/pages/test-3'} },
                  children: [ ]
                }
              } ]
            }
          },
          {
            links: {},
            data: {
              name: 'Sublevel 2',
              type: 'page',
              page: { links: { self: '/pages/test-2.1'} },
            }
          } ]
        }
      },
      {
        links: {},
        data: {
          name: 'Test 2',
          type: 'page',
          page: { links: { self: '/pages/test-4'} },
          children: [ ]
        }
      } ]
    };
  }

  beforeEach(function(done) {
    var promise = new Promise(function(resolve){
      var data = responseData();
      return resolve(data);
    });
    mockBackend = {};
    menu = new Menu(mockBackend, promise);
    menu.complete.then(function(){
      done();
    });
  });

  it('have items', function() {
    expect(menu.items.length).toBeGreaterThan(0);
  });

  it('should have a target', function() {
    expect(menu.items[0].target).toEqual('/pages/test-1');
  });

  it('should have a name', function() {
    expect(menu.items[0].name).toEqual('Test 1');
  });

  it('re-sync item lists for children', function() {
    var testOne = menu.items[0];
    expect(menu._response["data"][0]["data"]["children"][0]["data"]["name"]).toEqual("Sublevel 1");
    expect([for (item of testOne.children.items) item.name]).toEqual(["Sublevel 1", "Sublevel 2"]);
    expect(testOne.children.items[0].name).toEqual("Sublevel 1");
    var subOne = testOne.children.items.shift();
    testOne.children.items.push(subOne);
    testOne.children.syncItems();
    expect(testOne.children.items[0].name).toEqual("Sublevel 2");
    expect([for (item of menu._response["data"][0]["data"]["children"]) item["data"]["name"]]).toEqual(["Sublevel 2", "Sublevel 1"]);
  });

  it('should report external/internal', function() {
    expect(menu.items[0].internal()).toBeTruthy();
    expect(menu.items[0].external()).toBeFalsy();
  });

  it('should report hasChildren', function() {
    expect(menu.items[0].hasChildren()).toBeTruthy();
  });

  it('should have children', function() {
    expect(menu.items[0].children instanceof Menu).toBeTruthy();
  });

  it('should have grandchildren', function() {
    expect(menu.items[0].children.items[0].children instanceof Menu).toBeTruthy();
  });

  it('report no children correctly', function() {
    expect(menu.items[1].hasChildren()).toBeFalsy();
  });
});
