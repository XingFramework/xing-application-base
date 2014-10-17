import {configuration} from './config';

export default function setupLogging($rootScope, $state, noTable) {
  if(noTable){
    $rootScope.$on('$stateChangeStart', (event, toState, toParams, fromState, fromParams) => {
      /*jshint -W075 */
      console.log("Routing Event", event.name);
      console.log("From State", fromState.name, fromState.url);
      console.log("To State", toState.name, toState.url);
    });
    $rootScope.$on('$stateNotFound', (event, missingState) => {
      console.log("Routing Event", event.name);
      console.log("Missing state", missingState);
      console.log("Existing states");
      $state.get().forEach((state) => {
        console.log(state);
      });
      console.log("End of states");
    });
    $rootScope.$on('$stateChangeSuccess', (event, toState) => {
      console.log("Routing Event", event.name);
      console.log("To State", toState.name, toState.url);
    });
    $rootScope.$on('$stateChangeError', (event, toState, toParams, fromState, fromParams, error) => {
      console.log("Routing Event", event.name);
      console.log("From State", fromState);
      console.log("To State", toState);
      console.log("Error", error);
      console.log(error.stack);
    });
    $rootScope.$on('$viewContentLoaded', (event) => {
      console.log("view event", event.name);
    });
  } else {
    $rootScope.$on('$stateChangeStart', (event, toState, toParams, fromState, fromParams) => {
      /*jshint -W075 */
      console.group();
      console.table({event});
      console.table({fromState, toState});
      console.table({fromParams, toParams});
      console.groupEnd();
    });
    $rootScope.$on('$stateNotFound', (event, missingState) => {
      console.table({event, missingState});
      console.table($state.get());
    });
    $rootScope.$on('$stateChangeSuccess', (event, toState) => {
      console.group();
      console.table({event});
      console.table({toState});
      console.groupEnd();
    });
    $rootScope.$on('$stateChangeError', (event, toState, toParams, fromState, fromParams, error) => {
      console.group();
      /*jshint -W075 */
      console.table({event, fromState, fromParams, toState, toParams, error});
      console.log("ui-router error", error.stack);
      console.groupEnd();
    });
  }
}

angular.module( `${configuration.appName}.route-logger`, [] )
.run( [ '$rootScope', '$state', setupLogging ] );
