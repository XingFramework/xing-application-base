import {appName} from '../../../common/config';
import {} from '../../../common/toast/toast';
import {} from '../../../common/inflector';
import {} from '../../../common/serializer';
import {} from '../config/config';
import SessionsConfig from './sessionsStates';
import SessionsController from './sessionsControllers';

angular.module( `${appName}.auth.sessions`, [
  'ui.router.state',
  'ng-token-auth',
  `${appName}.toast`,
  'inflector',
  'serializer',
  `${appName}.auth.config`
])
.config(SessionsConfig)
.controller('SessionsCtrl', SessionsController);