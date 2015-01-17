import {appName} from '../../common/config';
import {} from '../../common/backend/backend';
import {} from '../adminEdit/adminEdit';
import PagesStates from './pagesStates';
import * as Controllers from './pagesControllers'; 

angular.module( `${appName}.pages`, [
  `${appName}.backend`,
  `${appName}.adminEditDirective`,
  'ui.router.state'
])
.controller('PagesCtrl', Controllers.PagesCtrl)
.controller('PageShowCtrl', Controllers.PageShowCtrl)
.controller('PageEditCtrl', Controllers.PageEditCtrl)
.controller('PageNewCtrl', Controllers.PageNewCtrl)
.config(PagesStates);
