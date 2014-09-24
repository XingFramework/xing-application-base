import {appName} from '../../common/config';
import {} from '../../common/backend/backend';
import {} from '../../../vendor/angular-ui-router/angular-ui-router';
import {} from "../adminOnly/adminOnly";
import {} from "../adminNav/adminNav";

angular.module( `${appName}.admin`, [
  `${appName}.backend`,
  `${appName}.adminOnly`,
  `${appName}.adminNav`,
  'ui.router.state'
]);

