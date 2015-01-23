import {Module} from 'a1atscript';
import Toast from '../../../common/toast/toast';
import Serializer from '../../../common/serializer';
import * as RegistrationsStates from './registrationsStates';
import RegistrationsController from './registrationsControllers';

var registrations = new Module( 'auth.registrations', [
  'ui.router.state',
  'ng-token-auth',
  Toast,
  Serializer,
  RegistrationsStates,
  RegistrationsController]);

export default registrations;
