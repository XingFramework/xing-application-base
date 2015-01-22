import {appName} from '../../common/config';
import Backend from '../../common/backend/backend';
import AdminOnly from "../adminOnly/adminOnly";
import AdminNav from "../adminNav/adminNav";
import AdminStates from "./adminStates";
import * as AdminControllers from "./adminControllers";
import { Module } from "a1atscript";

var Admin = new Module( `${appName}.admin`, [
  Backend,
  AdminOnly,
  AdminNav,
  'ui.router.state',
  AdminStates,
  AdminControllers
]);

export default Admin;
