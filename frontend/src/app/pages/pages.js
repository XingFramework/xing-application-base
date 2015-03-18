import Backend from 'backend/backend.js';
import adminEdit from '../adminEdit/adminEdit.js';
import * as PagesStates from './pagesStates.js';
import * as PagesControllers from './pagesControllers.js';
import { Module } from 'a1atscript';

var Pages = new Module( 'pages', [
  Backend,
  adminEdit,
  'ui.router.state',
  PagesControllers,
  PagesStates]);

export default Pages;
