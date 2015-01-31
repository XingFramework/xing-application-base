import {appName} from '../common/config';
import {} from '../../build/templates-app';
import {} from '../../build/templates-common';
import NavigationBar from './navigationBar/navigationBar';
import StateAttrs from './stateAttrs/stateAttrs';
import Backend from '../common/backend/backend';
import UIRouteLogger from "../common/ui-route-logger";
import Admin from './admin/admin';
import Auth from './auth/auth';
import Pages from './pages/pages';
import Menus from './menus/menus';
import Homepage from './homepage/homepage';
import Metadata from './metadata/metadata';
import ExampleForm from './exampleForm/exampleForm';
import ResponsiveMenu from './responsiveMenu/responsiveMenu';
import SessionLinks from './sessionLinks/sessionLinks';
import Toast from '../common/toast/toast';
import * as appConfig from './appConfig';
import RootCtrl from './rootController.js';
import { Module, Injector } from "a1atscript";

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
