import {Menu} from "../../src/common/server/menu";

describe('Menu class', function() {
  var menu;

  function responseData() {
    return {
      links: {},
      data: [ {
        links: {},
        data: {
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
        }
      } ]
    };
  }

  beforeEach(function(done) {
    var promise = new Promise(function(resolve){
      var data = responseData();
      return resolve(data);
    });
    menu = new Menu(promise);
    promise.then(function(){
      done()
    });
  });

  it('have items', function(done) {
    menu.responsePromise.then((response) => {
      expect(menu.items.length).toBeGreaterThan(0);
      done();
    });
  });

  it('should have a target', function(done) {
    menu.responsePromise.then((response) => {
      menu.items[0].responsePromise.then((response) => {
        expect(menu.items[0].target).toEqual('pages/test-1');
        done();
      });
    });
  });

  it('should have a name', function(done) {
    menu.responsePromise.then((response) => {
      menu.items[0].responsePromise.then((response) => {
        expect(menu.items[0].name).toEqual('Test 1');
        done();
      });
    });
  });

  it('should report external/internal', function(done) {
    menu.responsePromise.then((response) => {
      menu.items[0].responsePromise.then((response) => {
        expect(menu.items[0].internal()).toBeTruthy();
        expect(menu.items[0].external()).toBeFalsy();
        done();
      });
    });
  });

  xit('should report hasChildren', function(done) {
    menu.responsePromise.then((response) => {
      console.log("cmsBackend/Menu.js:77", "response", response);
      menu.items[0].responsePromise.then((response) => {
        console.log("cmsBackend/Menu.js:79", "response", response);
        console.log("cmsBackend/Menu.js:80", "menu.items[0].children", menu.items[0].children);
        menu.items[0].children.responsePromise.then((response) => {
          console.log("cmsBackend/Menu.js:81", "response", response);
          expect(menu.items[0].hasChildren()).toBeTruthy();
          done();
        });
      });
    });
  });

  xit('should have children', function(done) {
    menu.responsePromise.then((response) => {
      menu.items[0].responsePromise.then((response) => {
        menu.items[0].children.responsePromise.then((response) => {
          expect(menu.items[0].children.items[0] instanceof Menu).toBeTruthy();
          done();
        });
      });
    });
  });
});
