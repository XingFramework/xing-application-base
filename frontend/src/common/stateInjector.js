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

// An Injector must define an annotationClass getter and an instantiate method
export class StateInjector {
  get annotationClass() {
    return State;
  }

  annotateResolves(state) {
    state.resolve = {}
    for (var prop in state) {
      var resolveItem = state[prop];
      if (typeof resolveItem == "function") {
        resolveItem.annotations.forEach((annotation) => {
          if (annotation instanceof Resolve) {
            resolveItem['$inject'] = annotation.inject;
            state.resolve[prop] = resolveItem;
          }
        });
      }
    }
  }

  instantiate(module, dependencyList) {
    module.config(function($stateProvider) {
      dependencyList.forEach((dependencyObject) => {
        var metadata = dependencyObject.metadata;
        var StateClass = dependencyObject.dependency;
        var state = new StateClass();
        this.annotateResolves(state);
        $stateProvider.state(
          metadata.stateName,
          state
        );
      });
    })
  }
}

export class AdminOnlyState {
  @Resolve('$auth')
  onlyAdmin($auth) {
    return $auth.validateUser();
  }
}

// in simply apps being logged in means you're an admin
// override this in a more complex app
export class LoggedInOnlyState extends AdminOnlyState {
}

export class TrackAdminState {
  @Resolve('$auth')
  isAdmin($auth){
    return $auth.validateUser().then(
      (success) => {
      return true; },
      (failure) => {
        return false; }
    ).then((bool) => {
      return bool;
    });
  }
}

registerInjector('state', StateInjector);
