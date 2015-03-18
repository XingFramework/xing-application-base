import {appName} from 'config';
import {} from 'build/templates-app.js';
import {} from 'build/templates-common.js';
import StateAttrs from 'framework/stateAttrs.js';
import Backend from 'backend/backend.js';
import UIRouteLogger from "framework/ui-route-logger.js";
import NavigationBar from './navigationBar/navigationBar.js';
import Toast from 'components/toast/toast.js';
import { Module, Injector } from "a1atscript";

import Admin from './admin/admin.js';
import Auth from './auth/auth.js';
import Pages from './pages/pages.js';
import Menus from './menus/menus.js';
import Homepage from './homepage/homepage.js';
import Metadata from './metadata/metadata.js';
import ExampleForm from './exampleForm/exampleForm.js';
import ResponsiveMenu from './responsiveMenu/responsiveMenu.js';
import SessionLinks from './sessionLinks/sessionLinks.js';
import * as appConfig from './appConfig.js';
import RootCtrl from './rootController.js';

var app = new Module(appName, [
  'templates-app', 'templates-common', 'ui.router',
  'picardy.fontawesome',
  StateAttrs,
  UIRouteLogger,
  Menus,
  Homepage,
  Auth,
  Admin,
  ResponsiveMenu,
  Metadata,
  ExampleForm,
  SessionLinks,
  Toast,
  Pages,
  Backend,
  NavigationBar,
  appConfig,
  RootCtrl
]);

var injector = new Injector(appName);
injector.instantiate(app);
