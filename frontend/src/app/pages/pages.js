import {appName} from '../../common/config';
import Backend from '../../common/backend/backend';
import adminEdit from '../adminEdit/adminEdit';
import * as PagesStates from './pagesStates';
import * as PagesControllers from './pagesControllers';
import { Module } from 'a1atscript';

var Pages = new Module( `${appName}.pages`, [
  Backend,
  adminEdit,
  'ui.router.state',
  PagesControllers,
  PagesStates]);

export default Pages;
