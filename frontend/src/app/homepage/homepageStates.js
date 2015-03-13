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
      templateUrl: 'homepage/homepage-show.tpl.html',
      onEnter: function() {
          console.log("Test simple log line");
          console.table(["Array", "with", 4, "elements"]);
          console.table({ attr_1: 'JS object', attr_2: 'with', attr_3: 4, attr_4: "properties"});
          console.table([[ 2, 'dimensional', 'Array'],[ 'has', 2, 'rows', 'of', 'content']]);
          console.table({
            first:  { an:   'inner',  with: 'objects'},
            second: { also: 'object', with: 'more objects'},
          });
      }
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
