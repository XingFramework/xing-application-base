import {State, Resolve, AdminOnlyState, TrackAdminState} from 'stateInjector';

@State('root.homepage')
export class HomepageState extends TrackAdminState {
  constructor() {
    super();
    this.controller = 'HomepageCtrl';
    this.templateUrl = 'homepage/homepage.tpl.html';
    this.abstract = true;
    this.url = 'home';
  }

  @Resolve('isAdmin', 'backend')
  page(isAdmin, backend) {
    var role = "guest";
    if(isAdmin){ role = "admin"; }
    return backend.page("/homepage", role).complete.then(
      (page) => page,
      (nothing) => nothing
    );
  }
}

@State('root.homepage.show')
export class HomepageShowState {
  constructor() {
    this.url = '';
    this.controller = 'HomepageShowCtrl';
    this.templateUrl = 'homepage/homepage-show.tpl.html';
  }
}

@State('root.homepage.edit')
export class HomepageEditState extends AdminOnlyState {
  constructor() {
    super();
    this.templateUrl = 'homepage/homepage-edit.tpl.html';
    this.controller = 'HomepageEditCtrl';
  }
}
