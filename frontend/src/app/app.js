import {appName} from 'config';
import {} from 'build/templates-app.js';
import {} from 'build/templates-common.js';

import { Module, Injector } from "a1atscript";
import SessionLinks from 'components/sessionLinks/sessionLinks.js';

import {
  Fallback,
  Toast,
  ResponsiveMenu,
  UnimplementedDirective,
  StateAttrs,
  uiRouteLogger,
  stateFallback,
  ExampleForm,
} from 'xing-frontend-utils';

import Auth from './auth/auth.js';
import Homepage from './homepage/homepage.js';

import * as appConfig from './appConfig.js';
import RootCtrl from './rootController.js';

var app = new Module(appName, [
  'templates-app', 'templates-common', 'ui.router',
  'picardy.fontawesome',
  StateAttrs,
  uiRouteLogger,
  stateFallback,
  Homepage,
  Auth,
  Fallback,
  ResponsiveMenu,
  UnimplementedDirective,
  ExampleForm,
  SessionLinks,
  Toast,
  appConfig,
  RootCtrl
]);

var injector = new Injector(appName);
injector.instantiate(app);
