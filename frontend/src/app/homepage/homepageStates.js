import {appName} from '../../common/config';
import {} from './homepageModule';

angular.module(`${appName}.homepage`)
.config(function config( $stateProvider ) {
  $stateProvider

    .state( 'root.homepage', {
      controller: 'HomepageCtrl',
      templateUrl: 'homepage/homepage.tpl.html',
      abstract: true,
      url: 'home',
      resolve: {
        isAdmin($auth){
          return $auth.validateUser().then(
            (success) => {
            return true;
          },
            (failure) => {
              return false;
          }
          ).then((bool) => {
            return bool;
          });
        },
        page(isAdmin, backend) {
          var role = "guest";
          if(isAdmin){ role = "admin"; }
          return backend.page("/homepage", role).complete.then(
            (page) => page,
            (nothing) => nothing
          );
        }
      }
    })

    .state( 'root.homepage.show', {
      url: '',
      controller: 'HomepageShowCtrl',
      templateUrl: 'homepage/homepage-show.tpl.html'
    })

    .state( 'root.homepage.edit', {
      templateUrl: 'homepage/homepage-edit.tpl.html',
      controller: 'HomepageEditCtrl',
      resolve: {
        onlyAdmin($auth){
          return $auth.validateUser();
        }
      }
    });
});
