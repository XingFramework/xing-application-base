import {Menu} from "../../src/common/server/menu";

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
          children: [
            {
            links: {},
            data: {
              name: 'Sublevel 1',
              type: 'page',
              page: { links: { self: '/pages/test-2'} },
            }
          } ]
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
});
