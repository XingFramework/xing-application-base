import {appName} from '../../common/config';
import {} from '../../common/backend/backend';

angular.module( `${appName}.menus`, [
  `${appName}.backend`,
  'ui.router.state',
  'ui.tree'
]);
