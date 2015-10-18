import {Resolve} from 'stateInjector';

export class LoggedInOnlyState {
  @Resolve('$auth', '$state')
  currentUser($auth, $state){
    return $auth.validateUser().then(
      (user) => {
        return user;
      },
      (failure) => {
        $state.go('root.inner.sessions');
      }
    );
  }
}

// In base Xing, being logged in means you're an admin
// override AdminOnlyState and TrackAdminState in a more complex app
export class AdminOnlyState extends LoggedInOnlyState {
  @Resolve()
  onlyAdmin(){
    return true;
  }
}

export class TrackAdminState {
  @Resolve('$auth')
  isAdmin($auth){
    return $auth.validateUser().then(
      (success) => {
        return true;
      },
      (failure) => {
        return false;
      }
    );
  }
}
