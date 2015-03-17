import Backend from 'backend';
import * as ExampleFormStates from './exampleFormStates';
import ExampleFormController from './exampleFormControllers';
import { Module } from 'a1atscript';

var exampleForm = new Module( 'exampleForm', [
  'ui.router.state',
  Backend,
  ExampleFormStates,
  ExampleFormController
]);

export default exampleForm;
