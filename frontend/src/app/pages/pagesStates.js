import {State, Resolve} from 'stateInjector';
import {TrackAdminState, AdminOnlyState} from 'stateClasses';

@State('root.inner.page')
export class PagesState extends TrackAdminState {
  constructor() {
    super();
    this.url = '^/pages/';
    this.controller = 'PagesCtrl';
    this.abstract = true;
    this.template = "<ui-view lrd-state-attrs></ui-view>";
  }

  @Resolve('backend')
  page(backend) {
    return backend.createPage();
  }
}

@State( 'root.inner.page.new')
export class PageNewState extends AdminOnlyState {
  constructor() {
    super();
    this.url = 'new';
    this.templateUrl = 'pages/page-create.tpl.html';
    this.controller = 'PageNewCtrl';
  }
}

@State( 'root.inner.page.show')
export class PageShowState {
  constructor() {
    this.url = '*pageUrl';
    this.controller = 'PageShowCtrl';
    this.templateUrl = 'pages/pages.tpl.html';
  }

  @Resolve('isAdmin', 'page', '$stateParams')
  pageLoaded(isAdmin, page, $stateParams){
    if(isAdmin){
      page.role = "admin";
    } else {
      page.role = "guest";
    }
    page.loadFromShortLink($stateParams.pageUrl);
    return page.complete;
  }
}

@State('root.inner.page.edit')
export class PageEditState extends AdminOnlyState {
  constructor() {
    super();
    this.templateUrl = 'pages/page-edit.tpl.html';
    this.controller = 'PageEditCtrl';
  }
}
