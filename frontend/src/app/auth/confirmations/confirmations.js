import {appName} from 'config';
import {Module} from 'a1atscript';
import * as ConfirmationsStates from './confirmationsStates';

var confirmations = new Module( `${appName}.auth.confirmations`, [
  'ui.router.state',
  'ng-token-auth',
  ConfirmationsStates]);
export default confirmations;
