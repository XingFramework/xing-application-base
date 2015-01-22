import {appName} from 'config';
import {Module} from 'a1atscript';
import Backend from 'backend';
import AdminEdit from '../adminEdit/adminEdit';
import * as HomepageControllers from './homepageControllers';
import * as HomepageStates from './homepageStates';

var Homepage = new Module(`${appName}.homepage`, [
  Backend,
  AdminEdit,
  'ui.router.state',
  HomepageControllers,
  HomepageStates
]);

export default Homepage;
