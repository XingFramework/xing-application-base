import {State, LoggedInOnlyState} from "stateInjector";

@State('root.inner.confirmationsSuccess')
export class ConfirmationsSuccessState extends LoggedInOnlyState {
  constructor() {
    this.url = '^/confirmed';
    this.templateUrl = 'auth/confirmations/confirmations-success.tpl.html';
  }
}
