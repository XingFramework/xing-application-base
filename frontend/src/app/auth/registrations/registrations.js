import {appName} from '../../../common/config';
import {} from '../../../common/toast/toast';
import {} from '../../../common/serializer';
import RegistrationsConfig from './registrationsStates';
import RegistrationsController from './registrationsControllers';

angular.module( `${appName}.auth.registrations`, [
  'ui.router.state',
  'ng-token-auth',
  `${appName}.toast`,
  'serializer'
])
.config(RegistrationsConfig)
.controller('RegistrationsCtrl', RegistrationsController);