import {State} from 'stateInjector';

@State( 'root.inner.exampleForm')
export class ExampleFormState {
  constructor() {
    this.url = '^/example-form';
    this.controller = 'ExampleFormCtrl';
    this.templateUrl = "exampleForm/example-form.tpl.html";
  }
}
