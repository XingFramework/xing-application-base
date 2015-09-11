import ErrorLimiter from './errorLimiter.js';
import {Run} from 'a1atscript';

@Run("$rootScope", "$state")
export default function stateFallback($rootScope, $state) {
  var limiter = new ErrorLimiter($state, "errorFallback");
  $rootScope.$on('$stateChangeError', (event, toState, toParams, fromState, fromParams, error) => {
    limiter.transitionError(fromState, toState);
  });
  $rootScope.$on('$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) => {
    limiter.transitionSuccess(fromState, toState);
  });
}
