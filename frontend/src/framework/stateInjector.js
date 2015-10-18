import {registerInjector} from 'a1atscript'

export class State {
   constructor(stateName) {
     this.stateName = stateName;
   }
}

export class Resolve {
  constructor(...inject) {
    this.inject = inject;
  }
}

export class Inject {
  constructor(...inject) {
    this.inject = inject;
  }
}

// An Injector must define an annotationClass getter and an instantiate method
export class StateInjector {
  get annotationClass() {
    return State;
  }

  annotateResolves(state) {
    state.resolve = {}
    for (var prop in state) {
      if (typeof state[prop] == "function") {
        var resolveItem = state[prop];
        resolveItem.annotations.forEach((annotation) => {
          if (annotation instanceof Resolve) {
            resolveItem['$inject'] = annotation.inject;
            state.resolve[prop] = resolveItem;
          }
          if (annotation instanceof Inject) {
            resolveItem['$inject'] = annotation.inject;
          }
        });
      }
    }
  }

  instantiate(module, dependencyList) {
    var injector = this;
    module.config(function($stateProvider) {
      dependencyList.forEach((dependencyObject) => {
        var metadata = dependencyObject.metadata;
        var StateClass = dependencyObject.dependency;
        var state = new StateClass();
        injector.annotateResolves(state);
        $stateProvider.state(
          metadata.stateName,
          state
        );
      });
    })
  }
}

registerInjector('state', StateInjector);
