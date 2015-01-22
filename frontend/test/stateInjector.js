import {State, Resolve} from "../src/common/stateInjector";
import {Module, Injector} from "a1atscript";

@State('root.main.inner')
class RootMainInnerState {
  constructor() {
    this.template = 'awesome/awesome.html';
    this.controller = 'AwesomeController';
  }

  @Resolve('Backend')
  model(Backend) {
  }

  @Resolve('AuthService')
  user(AuthService) {
  }

}

var AppModule = new Module('AppModule', ['ui.router.state', RootMainInnerState])

describe("State Injection", function() {

  beforeEach(function() {
    var injector = new Injector();
    injector.instantiate(AppModule);
    module('AppModule');
  });

  describe("state", function() {

    beforeEach(mock.inject(function($state) {
      var state = $state.get('root.main.inner');
    }));

    it("should setup state correctly", function() {
      expect(state.template).toEqual('awesome/awesome.html');
      expect(state.controller).toEqual('AwesomeController');
      expect(state.resolve.model['$inject']).toEqual(['Backend']);
    });

  });
});
