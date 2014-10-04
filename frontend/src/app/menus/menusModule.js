import {appName} from '../../common/config';
import {} from '../../common/backend/backend';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';
import {} from '../../../vendor/angular-ui-tree/angular-ui-tree';

angular.module( `${appName}.menus`, [
  `${appName}.backend`,
  'ui.router.state',
  'ui.tree'
]);
