export default class ErrorLimiter {
  constructor(uiState, failsafeStateName){
    this.uiState = uiState;
    this.failsafeStateName = failsafeStateName;
    this.failedTransitions = {};
    this.errorLimit = 3;
  }

  recordTransition(from, to) {
    if(typeof this.failedTransitions[from] === "undefined"){
      this.failedTransitions[from] = {};
    }

    if(typeof this.failedTransitions[from][to] === "undefined"){
      this.failedTransitions[from][to] = 0;
    }

    this.failedTransitions[from][to] = this.failedTransitions[from][to] + 1;
  }

  transitionCount(from, to) {
    if(typeof this.failedTransitions[from] === "undefined"){
      return 0;
    }

    if(typeof this.failedTransitions[from][to] === "undefined"){
      return 0;
    }

    return this.failedTransitions[from][to];
  }

  goToFailsafe() {
    this.uiState.go(this.failsafeStateName);
  }

  clearTransitionRecords() {
    this.failedTransitions = {};
  }

  transitionError(fromState, toState) {
    var from = fromState.name, to = toState.name;
    this.recordTransition(from, to);
    if(this.transitionCount(from, to) >= this.errorLimit){
      this.goToFailsafe();
    }
  }

  transitionSuccess(fromState, toState) {
    var from = fromState.name, to = toState.name;
    this.clearTransitionRecords();
  }
}
