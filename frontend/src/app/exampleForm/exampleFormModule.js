import {appName} from '../../common/config';
import {} from '../../common/backend/backend';

angular.module( `${appName}.exampleForm`, [
  `${appName}.backend`,
  'ui.router.state'
]);
