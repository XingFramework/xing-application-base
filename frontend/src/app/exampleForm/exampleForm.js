import {appName} from '../../common/config';
import Backend from '../../common/backend/backend';
import ExampleFormStates from './exampleFormStates';
import ExampleFormController from './exampleFormControllers';
import { Module } from 'a1atscript';

var exampleForm = new Module( `${appName}.exampleForm`, [
  'ui.router.state',
  Backend,
  ExampleFormStates,
  ExampleFormController
]);

export default exampleForm;
