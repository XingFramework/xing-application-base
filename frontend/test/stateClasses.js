import {LoggedInOnlyState, AdminOnlyState, TrackAdminState} from 'stateClasses';

describe("Base States", function() {
  var state, mockState, mockAuth, mockUser, mockBackend;

  describe("LoggedInOnlyState", function(){
    beforeEach(function() {
      state = new LoggedInOnlyState();
      mockAuth = {
        validateUser() {}
      }
      mockState = {
        go() {}
      }
      mockUser = "some user";
    });

    describe("logged in", function() {
      beforeEach(function() {
        spyOn(mockAuth, 'validateUser').and.returnValue(new Promise((resolve, reject) => { resolve(mockUser); }));
      });

      it("should resolve currentUser", function(done) {
        state.currentUser(mockAuth, mockState).then((user) => {
          expect(user).toEqual("some user");
          done();
        });
      });
    });

    describe("not logged in", function() {
      beforeEach(function() {
        spyOn(mockAuth, 'validateUser').and.returnValue(new Promise((resolve, reject) => { reject(); }));
        spyOn(mockState, "go").and.returnValue('awesome');
      });

      it("should redirect", function(done) {
        state.currentUser(mockAuth, mockState).then((failure) => {
          expect(mockState.go).toHaveBeenCalledWith('root.inner.sessions');
          done();
        });
      });
    });
  });

  describe("AdminOnlyState", function(){
    beforeEach(function() {
      state = new AdminOnlyState();
    });

    it("should extend LoggedInOnlyState", function() {
      expect(state instanceof LoggedInOnlyState).toBe(true);
    });

    it("should resolve onlyAdmin", function() {
      expect(state.onlyAdmin()).toEqual(true);
    });
  });
});
