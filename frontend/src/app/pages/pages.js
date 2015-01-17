import {appName} from '../../common/config';
import {} from '../../common/backend/backend';
import {} from '../adminEdit/adminEdit';
import PagesStates from './pagesStates';
import {
  PagesCtrl, PageShowCtrl, PageEditCtrl, PageNewCtrl
} from './pagesControllers'; 

angular.module( `${appName}.pages`, [
  `${appName}.backend`,
  `${appName}.adminEditDirective`,
  'ui.router.state'
])
.controller('PagesCtrl', PagesCtrl)
.controller('PageShowCtrl', PageShowCtrl)
.controller('PageEditCtrl', PageEditCtrl)
.controller('PageNewCtrl', PageNewCtrl)
.config(PagesStates);
