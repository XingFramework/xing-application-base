import {Menu} from "../../src/common/server/menu";

describe('Menu class', function() {
  var menu;

  function responseData() {
    return {
      links: {},
      data: [ {
        name: 'Test 1',
        url: 'pages/test-1',
        type: 'page',
        children: [
          {
          links: {},
          data: {
            name: 'Sublevel 1',
            url: 'pages/test-2',
            type: 'page'
          }
        } ]
      } ]
    };
  }

  beforeEach(function() {
    menu = new Menu(
      new Promise(function(resolve){ return resolve(responseData()); })
    );
  });

  it('should have a target', function() {
    expect(menu.target).toEqual('pages/test-1');
  });

  it('should have a name', function() {
    expect(menu.name).toEqual('Test 1');
  });

  it('should report external/internal', function() {
    expect(menu.internal()).toBeTruthy();
    expect(menu.external()).toBeFalsy();
  });

  it('should report hasChildren', function() {
    expect(menu.hasChildren()).toBeTruthy();
  });

  it('should have children', function() {
    expect(menu.children[0] instanceof Menu).toBeTruthy();
  });


});
