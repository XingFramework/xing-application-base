import {State, Resolve, LoggedInOnlyState} from 'stateInjector';

@State( 'root.inner.sessions')
export class SessionsState {
  constructor() {
    this.url = '^/sign-in';
    this.controller = 'SessionsCtrl';
    this.templateUrl = 'auth/sessions/sessions.tpl.html';
  }
}

@State( 'root.inner.sessionsSuccess')
export class SessionsSuccessState extends LoggedInOnlyState {
  constructor() {
    this.url = '^/signed-in';
    this.templateUrl = 'auth/sessions/sessions-success.tpl.html';
  }
}
