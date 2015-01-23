import {Module} from 'a1atscript';
import * as PasswordsStates from './passwordsStates';
import * as PasswordsControllers from './passwordsControllers';

var passwords = new Module('auth.passwords', [
  'ui.router.state',
  'ng-token-auth',
  PasswordsStates,
  PasswordsControllers]);

export default passwords;
