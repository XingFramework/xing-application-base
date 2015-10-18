import {appName} from 'config';
import {} from 'build/templates-app.js';
import {} from 'build/templates-common.js';
import StateAttrs from 'framework/stateAttrs.js';
import Backend from 'backend/backend.js';
import UIRouteLogger from "framework/ui-route-logger.js";
import StateFallback from 'framework/stateFallback/stateFallback.js';

import { Module, Injector } from "a1atscript";

import NavigationBar from 'components/navigationBar/navigationBar.js';
import Toast from 'components/toast/toast.js';
import ResponsiveMenu from 'components/responsiveMenu/responsiveMenu.js';
import SessionLinks from 'components/sessionLinks/sessionLinks.js';
import Metadata from 'components/metadata/metadata.js';
import XngUnimplementedDirective from 'components/unimplemented/unimplemented.js'

import Fallback from './fallback/fallback.js'
import Admin from './admin/admin.js';
import Auth from './auth/auth.js';
import Pages from './pages/pages.js';
import Menus from './menus/menus.js';
import Homepage from './homepage/homepage.js';
import ExampleForm from './exampleForm/exampleForm.js';

import * as appConfig from './appConfig.js';
import RootCtrl from './rootController.js';

var app = new Module(appName, [
  'templates-app', 'templates-common', 'ui.router',
  'picardy.fontawesome',
  StateAttrs,
  UIRouteLogger,
  StateFallback,
  Menus,
  Homepage,
  Auth,
  Fallback,
  Admin,
  ResponsiveMenu,
  Metadata,
  XngUnimplementedDirective,
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
