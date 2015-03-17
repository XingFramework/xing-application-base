import {appName} from 'config';
import {} from 'templates-app';
import {} from 'templates-common';
import StateAttrs from 'stateAttrs';
import Backend from 'backend';
import UIRouteLogger from "ui-route-logger";
import { Module, Injector } from "a1atscript";

import NavigationBar from 'components/navigationBar';
import Toast from 'components/toast';
import ResponsiveMenu from 'components/responsiveMenu';
import SessionLinks from 'components/sessionLinks';
import Metadata from 'components/metadata';

import Admin from './admin/admin';
import Auth from './auth/auth';
import Pages from './pages/pages';
import Menus from './menus/menus';
import Homepage from './homepage/homepage';
import ExampleForm from './exampleForm/exampleForm';

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
