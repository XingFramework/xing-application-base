import {appName} from '../../common/config';
import {} from '../../common/backend/backend';
import {} from '../adminEdit/adminEdit';

angular.module( `${appName}.homepage`, [
  `${appName}.backend`,
  `${appName}.adminEditDirective`,
  'ui.router.state'
]);
