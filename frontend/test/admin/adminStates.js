import {AdminState,
        AdminPagesState,
        AdminMenusState,
        AdminDocumentsState,
        AdminImagesState} from '../../src/app/admin/adminStates.js';
import {AdminOnlyState} from 'stateClasses';

describe('admin states', function() {
  var state, mockBackend, mockPageList, mockMenuList;
  describe('root.admin', function() {
    beforeEach(function() {
      state = new AdminState();
    });

    it("should extend AdminOnlyState", function() {
      expect(state instanceof AdminOnlyState).toBe(true);
    });

    it('should respond to URL', function() {
      expect(state.url).toEqual('admin');
    });

    it('should render template url', function() {
      expect(state.templateUrl).toEqual('admin/admin.tpl.html');
    });
  });

  describe('root.admin.pages', function() {
    beforeEach(function() {
      mockBackend = {
        pageList() {
          return mockPageList;
        }
      };
      mockPageList = {
        complete: "list of pages"
      };
      state = new AdminPagesState();
    });

    it('should respond to URL', function() {
      expect(state.url).toEqual('/pages');
    });

    it('should render template url', function() {
      expect(state.templateUrl).toEqual('admin/pages.tpl.html');
    });

    it('should resolve pageList', function() {
      expect(state.pageList(mockBackend)).toEqual('list of pages');
    });
  });

  describe('root.admin.menus', function() {
    beforeEach(function() {
      mockBackend = {
        menuList() {
          return mockMenuList;
        }
      };
      mockMenuList = {
        complete: "list of menus"
      };
      state = new AdminMenusState();
    });

    it('should respond to URL', function() {
      expect(state.url).toEqual('/menus');
    });

    it("should have the correct controller", function() {
      expect(state.controller).toEqual('AdminMenusCtrl');
    });

    it('should render template url', function() {
      expect(state.templateUrl).toEqual('admin/menus.tpl.html');
    });

    it('should resolve menuList', function() {
      expect(state.menuList(mockBackend)).toEqual('list of menus');
    });
  });

  describe('root.admin.documents', function() {
    beforeEach(function() {
      state = new AdminDocumentsState();
    });

    it('should respond to URL', function() {
      expect(state.url).toEqual('/documents');
    });

    it("should have the correct controller", function() {
      expect(state.controller).toEqual('AdminDocumentsCtrl');
    });

    it('should render template url', function() {
      expect(state.templateUrl).toEqual('admin/documents.tpl.html');
    });
  });

  describe('root.admin.images', function() {
    beforeEach(function() {
      state = new AdminImagesState();
    });

    it('should respond to URL', function() {
      expect(state.url).toEqual('/images');
    });

    it("should have the correct controller", function() {
      expect(state.controller).toEqual('AdminImagesCtrl');
    });

    it('should render template url', function() {
      expect(state.templateUrl).toEqual('admin/images.tpl.html');
    });
  });
});
