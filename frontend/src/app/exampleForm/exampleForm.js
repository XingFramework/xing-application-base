import Backend from 'backend/backend.js';
import * as ExampleFormStates from './exampleFormStates.js';
import ExampleFormController from './exampleFormControllers.js';
import { Module } from 'a1atscript';

var exampleForm = new Module( 'exampleForm', [
  'ui.router.state',
  Backend,
  ExampleFormStates,
  ExampleFormController
]);

export default exampleForm;
