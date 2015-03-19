import Backend from 'backend/backend.js';
import AdminOnly from "components/adminOnly/adminOnly.js";
import AdminNav from "components/adminNav/adminNav.js";
import * as AdminStates from "./adminStates.js";
import * as AdminControllers from "./adminControllers.js";
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
