import {appName} from '../../../common/config';
import PasswordsConfig from './passwordsStates';
import {
  PasswordsRequestController,
  PasswordsUpdateController
} from './passwordsControllers';

angular.module( `${appName}.auth.passwords`, [
  'ui.router.state',
  'ng-token-auth'
])
.config(PasswordsConfig)
.controller('PasswordsRequestCtrl', PasswordsRequestController)
.controller('PasswordsUpdateCtrl', PasswordsUpdateController);
