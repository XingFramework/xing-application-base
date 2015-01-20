import {appName} from '../../common/config';
import Backend from '../../common/backend/backend';
import adminEdit from '../adminEdit/adminEdit';
import PagesStates from './pagesStates';
import * as Controllers from './pagesControllers';
import { Module } from 'a1atscript';

var Pages = new Module( `${appName}.pages`, [
  Backend,
  adminEdit,
  'ui.router.state',
  Controllers,
  PagesStates]);

export default Pages;
