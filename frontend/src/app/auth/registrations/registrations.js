import {Module} from 'a1atscript';
import Toast from 'components/toast/toast.js';
import Serializer from 'framework/serializer.js';
import * as RegistrationsStates from './registrationsStates.js';
import RegistrationsController from './registrationsControllers.js';

var registrations = new Module( 'auth.registrations', [
  'ui.router.state',
  'ng-token-auth',
  Toast,
  Serializer,
  RegistrationsStates,
  RegistrationsController]);

export default registrations;
