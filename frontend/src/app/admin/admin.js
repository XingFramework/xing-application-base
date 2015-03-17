import Backend from 'backend';
import AdminOnly from "../adminOnly/adminOnly";
import AdminNav from "../adminNav/adminNav";
import * as AdminStates from "./adminStates";
import * as AdminControllers from "./adminControllers";
import { Module } from "a1atscript";

var Admin = new Module( 'admin', [
  Backend,
  AdminOnly,
  AdminNav,
  'ui.router.state',
  AdminStates,
  AdminControllers
]);

export default Admin;
