import {appName} from '../../../common/config';
import ConfirmationsConfig from './confirmationsStates';

angular.module( `${appName}.auth.confirmations`, [
  'ui.router.state',
  'ng-token-auth'
])
.config(ConfirmationsConfig);