import {appName} from 'config';
import {Module} from 'a1atscript';
import Toast from '../../../common/toast/toast';
import Inflector from '../../../common/inflector';
import Serializer from '../../../common/serializer';
import Config from '../config/config';
import * as SessionsStates from './sessionsStates';
import SessionsController from './sessionsControllers';

var sessions = new Module(`${appName}.auth.sessions`, [
  'ui.router.state',
  'ng-token-auth',
  Toast,
  Inflector,
  Serializer,
  Config,
  SessionsStates,
  SessionsController]);

export default sessions;
