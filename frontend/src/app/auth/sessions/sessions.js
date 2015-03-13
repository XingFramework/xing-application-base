import {Module} from 'a1atscript';
import Toast from 'components/toast';
import Inflector from 'inflector';
import Serializer from 'serializer';
import Config from '../config/config';
import * as SessionsStates from './sessionsStates';
import SessionsController from './sessionsControllers';

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
