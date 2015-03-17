import Backend from 'backend';
import adminEdit from 'components/adminEdit';
import * as PagesStates from './pagesStates';
import * as PagesControllers from './pagesControllers';
import { Module } from 'a1atscript';

var Pages = new Module( 'pages', [
  Backend,
  adminEdit,
  'ui.router.state',
  PagesControllers,
  PagesStates]);

export default Pages;
