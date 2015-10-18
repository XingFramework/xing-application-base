import {State, Resolve} from 'stateInjector';
import {TrackAdminState, AdminOnlyState} from 'stateClasses';

@State('root.admin.menu')
export class AdminMenuState extends TrackAdminState {
  constructor() {
    super();
    this.url = '^/menus/';
    this.controller = 'MenusCtrl';
    this.abstract = true;
    this.template = "<ui-view lrd-state-attrs></ui-view>";
  }

  @Resolve('backend')
  menu(backend) { return backend.createMenu(); }

  @Resolve('backend')
  pageList(backend) { return backend.pageList().complete; }
}

@State('root.admin.menu.new')
export class AdminMenuNewState extends AdminOnlyState {
  constructor() {
    super();
    this.url = 'new';
    this.controller = 'MenuNewCtrl';
    //this.templateUrl = 'menus/menu-create.tpl.html';
  }
}

@State('root.admin.menu.show')
export class AdminMenuShowState {
  constructor() {
    this.url = '*menuUrl';
    this.controller = 'MenuShowCtrl';
    //this.templateUrl = 'menus/menus.tpl.html';
  }

  @Resolve('isAdmin', 'menu', '$stateParams')
  menuLoaded(isAdmin, menu, $stateParams){
    if(isAdmin){
      menu.role = "admin";
    } else {
      menu.role = "guest";
    }
    menu.loadFrom($stateParams.menuUrl);
    return menu.complete.catch((error) => {
      console.log("menus/menusStates.js:40", "error", error);
      throw error;
    });
  }
}

@State('root.admin.menu.edit')
export class AdminMenuEditState extends AdminOnlyState {
  constructor() {
    super();
    this.templateUrl = 'menus/edit.tpl.html';
    this.controller = 'MenuEditCtrl';
  }
}
