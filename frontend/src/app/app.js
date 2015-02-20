import {appName} from 'config';
import {} from 'templates-app';
import {} from 'templates-common';
import StateAttrs from 'stateAttrs';
import Backend from 'backend';
import UIRouteLogger from "ui-route-logger";
import NavigationBar from './navigationBar/navigationBar';
import Toast from 'components/toast';
import { Module, Injector } from "a1atscript";

import Admin from './admin/admin';
import Auth from './auth/auth';
import Pages from './pages/pages';
import Menus from './menus/menus';
import Homepage from './homepage/homepage';
import Metadata from './metadata/metadata';
import ExampleForm from './exampleForm/exampleForm';
import ResponsiveMenu from './responsiveMenu/responsiveMenu';
import SessionLinks from './sessionLinks/sessionLinks';
import * as appConfig from './appConfig';
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
