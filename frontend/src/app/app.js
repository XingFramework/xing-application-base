import {appName} from '../common/config';
import {} from '../../build/templates-app';
import {} from '../../build/templates-common';
import NavigationBar from './navigationBar/navigationBar';
import {} from './stateAttrs/stateAttrs';
import Backend from '../common/backend/backend';
import {} from "../common/ui-route-logger";
import {} from './admin/admin';
import {} from './auth/auth';
import Pages from './pages/pages';
import {} from './menus/menus';
import {} from './homepage/homepage';
import {} from './metadata/metadata';
import {} from './exampleForm/exampleForm';
import {} from './responsiveMenu/responsiveMenu';
import {} from './sessionLinks/sessionLinks';
import {} from '../common/toast/toast';
import appConfig from './appConfig';
import RootCtrl from './rootController.js';
import {Module,
  Injector
} from "a1atscript";

var app = new Module(appName, [
  'templates-app', 'templates-common', 'ui.router',
  'picardy.fontawesome',
  `${appName}.stateAttrs`,
  `${appName}.route-logger`,
  `${appName}.menus`,
  `${appName}.homepage`,
  `${appName}.auth`,
  `${appName}.admin`,
  `${appName}.responsiveMenu`,
  `${appName}.metadata`,
  `${appName}.exampleForm`,
  `${appName}.sessionLinks`,
  `${appName}.toast`,
  Pages,
  Backend,
  NavigationBar,
  appConfig,
  RootCtrl
]);

var injector = new Injector();
injector.instantiate(app);
