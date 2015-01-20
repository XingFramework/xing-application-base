import { appName } from '../../common/config';
import { Module } from "a1atscript";
import froalaConfig from './froalaConfig';
import lrdAdminEditable from './adminEditableDirective';

var adminEdit = new Module(`${appName}.adminEditDirective`, [
  'froala',
  lrdAdminEditable,
  froalaConfig]);

export default adminEdit;
