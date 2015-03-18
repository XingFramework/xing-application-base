import {Module} from 'a1atscript';
import Backend from 'backend/backend.js';
import AdminEdit from '../adminEdit/adminEdit.js';
import * as HomepageControllers from './homepageControllers.js';
import * as HomepageStates from './homepageStates.js';

var Homepage = new Module('homepage', [
  Backend,
  AdminEdit,
  'ui.router.state',
  HomepageControllers,
  HomepageStates
]);

export default Homepage;
