import {appName} from '../../common/config';
import {} from '../../common/backend/backend';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';
import {} from '../adminEdit/adminEdit';

angular.module( `${appName}.pages`, [
  `${appName}.backend`,
  `${appName}.adminEditDirective`,
  'ui.router.state'
]);
