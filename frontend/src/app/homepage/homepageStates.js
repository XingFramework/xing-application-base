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
          console.log('home A - isAdmin');
          return $auth.validateUser().then(
            (success) => {
            console.log('Found Admin');
            return true;
          },
            (failure) => {
            console.log('Found No Admin');
              return false;
          }
          ).then((bool) => {
            console.log('Admin state : bool');
            return bool;
          });
        },
        page(isAdmin, backend) {
          console.log('home B - page');
          console.log('backend: ' + backend);
          var role = "guest";
          if(isAdmin){ role = "admin"; }
          console.log('home c - page');
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
