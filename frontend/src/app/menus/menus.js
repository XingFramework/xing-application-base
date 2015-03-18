import {Module} from 'a1atscript';
import Backend from 'backend/backend.js';
import * as MenuStates from './menusStates.js';
import * as MenuControllers from './menusControllers.js';

var Menus = new Module( 'menus', [
  Backend,
  'ui.router.state',
  'ui.tree',
  MenuStates,
  MenuControllers
]);

export default Menus;
