import {State, Resolve} from "../src/common/stateInjector";
import {Module, Injector} from "a1atscript";
import {} from './support/testStates';
import {appName} from 'config';

@State('root.inner.page')
class RootInnerPageState {
  constructor() {
    this.templateUrl = 'awesome/awesome.html';
    this.controller = 'AwesomeController';
  }

  @Resolve('Backend')
  model(Backend) {
  }

  @Resolve('AuthService')
  user(AuthService) {
  }

}

var AppModule = new Module('AppModule', ['ui.router.state', RootInnerPageState])

describe("State Injection", function() {

  beforeEach(function() {
    var injector = new Injector();
    injector.instantiate(AppModule);
    module(`${appName}.testStates`);
    module('AppModule');
  });

  describe("state", function() {

    var state;

    beforeEach(inject(function($state) {
      state = $state.get('root.inner.page');
    }));

    it("should setup state correctly", function() {
      expect(state.templateUrl).toEqual('awesome/awesome.html');
      expect(state.controller).toEqual('AwesomeController');
      expect(state.resolve.model['$inject']).toEqual(['Backend']);
    });

  });
});
