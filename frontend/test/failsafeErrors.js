import FailsafeErrors from 'framework/stateFallback/errorLimiter.js';

describe("FailsafeErrors", () => {
  var errors, mockStates, failsafeName;
  var failOne, failTwo, root, okay;

  beforeEach(() => {
    failOne = { name: "some.dumb.state" };
    failTwo = { name: "another.dumb.state" };
    root = { name: "" };
    okay = { name: "somewhere.sensible" };
  });

  beforeEach(() => {
    failsafeName = "omgeverythingisterrible";
    mockStates = jasmine.createSpyObj("$state", ["go"]);
    errors = new FailsafeErrors(mockStates, failsafeName);
  });


  ddescribe('nearly triggered', function() {
    beforeEach(function() {
      for(let i = 0; i < errors.errorLimit - 1; i++) {
        errors.transitionError(root, failOne);
        errors.transitionError(failOne, failTwo);
        errors.transitionError(failTwo, root);
      }
    });

    it("goes to failsafe at error limit", () => {
      expect(mockStates.go.calls.any()).toBe(false);

      errors.transitionError(root, failOne);

      expect(mockStates.go.calls.any()).toBe(true);
      expect(mockStates.go.calls.argsFor(0)).toEqual([failsafeName]);
    });

    it('forgives everything on a successful transition', () => {
      expect(mockStates.go.calls.any()).toBe(false);

      errors.transitionSuccess(root, okay);
      errors.transitionError(root, failOne);

      expect(mockStates.go.calls.any()).toBe(false);
    });

  });

});
