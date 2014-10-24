import {appName} from '../../common/config';
import {} from './homepageModule';

angular.module(`${appName}.homepage`)
.config(function config( $stateProvider ) {
  $stateProvider

    .state( 'root.homepage', {
      controller: 'HomepageCtrl',
      template: "<ui-view lrd-state-attrs></ui-view>",
      abstract: true,
      url: 'home',
      resolve: {
        isAdmin($auth){
          return $auth.validateUser().then(
            (success) => {
            return true; },
            (failure) => {
              return false; }
          ).then((bool) => {
            return bool;
          });
        },
        page(isAdmin, backend) {
          var role = "guest";
          if(isAdmin){ role = "admin"; }
          return backend.page("/homepage", role).complete;
        }
      }
    })

    .state( 'root.homepage.show', {
      url: '',
      controller: 'HomepageShowCtrl',
      templateUrl: 'homepage/homepage.tpl.html'
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
