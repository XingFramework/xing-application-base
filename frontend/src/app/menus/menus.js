import {Module} from 'a1atscript';
import Backend from 'backend';
import * as MenuStates from './menusStates';
import * as MenuControllers from './menusControllers';

var Menus = new Module( 'menus', [
  Backend,
  'ui.router.state',
  'ui.tree',
  MenuStates,
  MenuControllers
]);

export default Menus;
