import {State, Resolve} from 'stateInjector';
import {AdminOnlyState} from 'stateClasses';

@State('root.admin')
export class AdminState extends AdminOnlyState {
  constructor() {
    super();
    this.url = 'admin';
    this.templateUrl = 'admin/admin.tpl.html';
  }
}

@State('root.admin.pages')
export class AdminPagesState {
  constructor() {
    this.url = '/pages';
    this.controller = 'AdminPagesCtrl';
    this.templateUrl = 'admin/pages.tpl.html';
  }

  @Resolve('backend')
  pageList(backend) {
    return backend.pageList().complete;
  }
}

@State( 'root.admin.menus')
export class AdminMenusState {
  constructor() {
    this.url ='/menus';
    this.controller = 'AdminMenusCtrl';
    this.templateUrl = 'admin/menus.tpl.html';
  }

  @Resolve('backend')
  menuList(backend) {
    return backend.menuList().complete;
  }
}

@State( 'root.admin.documents')
export class AdminDocumentsState {
  constructor() {
    this.url = '/documents';
    this.controller = 'AdminDocumentsCtrl';
    this.templateUrl = 'admin/documents.tpl.html';
  }
}

@State('root.admin.images')
export class AdminImagesState {
  constructor() {
    this.url = '/images';
    this.controller = 'AdminImagesCtrl';
    this.templateUrl = 'admin/images.tpl.html';
  }
}
