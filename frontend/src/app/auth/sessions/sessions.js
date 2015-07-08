import {Module} from 'a1atscript';
import Toast from 'components/toast/toast.js';
import Inflector from 'xing-inflector';
import Serializer from 'framework/serializer.js';
import Config from '../config/config.js';
import * as SessionsStates from './sessionsStates.js';
import SessionsController from './sessionsControllers.js';

var sessions = new Module('auth.sessions', [
  'ui.router.state',
  'ng-token-auth',
  Toast,
  Inflector,
  Serializer,
  Config,
  SessionsStates,
  SessionsController]);

export default sessions;
