import {State, Resolve} from '../../common/stateInjector';

@State('root.admin')
export class AdminState {
  constructor() {
    this.url = 'admin/';
    this.templateUrl = 'admin/admin.tpl.html';
  }

  @Resolve('$auth')
  isAdmin($auth){
    return $auth.validateUser();
  }
}

@State('root.admin.pages', [pageList])
export class AdminPagesState {
  constructor() {
    this.url = 'pages';
    this.controller = 'AdminPagesCtrl';
    this.templateUrl = 'admin/pages.tpl.html';
  }

  @Resolve('backend')
  pageList(backend) {
    return backend.pageList().complete;
  }
}

@State( 'root.admin.menus', [menuList])
class AdminMenusState {
  constructor() {
    this.url ='menus';
    this.controller = 'AdminMenusCtrl';
    this.templateUrl = 'admin/menus.tpl.html';
  }

  @Resolve('backend')
  menuList(backend) {
    return backend.menuList().complete;
  }
}

@State( 'root.admin.documents')
class AdminDocumentsState {
  constructor() {
    this.url = 'documents';
    this.controller = 'AdminDocumentsCtrl';
    this.templateUrl = 'admin/documents.tpl.html'
  }
}

@State('root.admin.images')
class AdminImagesState {
  constructor() {
    this.url = 'images';
    this.controller = 'AdminImagesCtrl';
    templateUrl = 'admin/images.tpl.html';
  }
}
