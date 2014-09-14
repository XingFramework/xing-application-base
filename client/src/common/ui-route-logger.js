import {configuration} from './config';

angular.module( `${configuration.appName}.route-logger`, [] )
.run( function ( $rootScope ) {
  $rootScope.$on('$stateChangeStart', (event, toState, toParams, fromState, fromParams) => {
    /*jshint -W075 */
    console.table({event, fromState, fromParams, toState, toParams});
  });
  $rootScope.$on('$stateNotFound', (event, missingState) => {
    console.table({event, missingState});
  });
  $rootScope.$on('$stateChangeSuccess', (event, toState) => {
    console.table({event, toState});
  });
  $rootScope.$on('$stateChangeError', (event, toState, toParams, fromState, fromParams, error) => {
    console.group();
    /*jshint -W075 */
    console.table({event, fromState, fromParams, toState, toParams, error});
    console.log("ui-router", error.stack);
    console.endGroup();
  });
});
