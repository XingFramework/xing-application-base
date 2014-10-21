import {appName} from '../../common/config';
import {} from './pagesModule';

angular.module(`${appName}.pages`)
.config(function config( $stateProvider ) {
  $stateProvider

    .state( 'root.inner.page', {
      url: '^/pages/',
      controller: 'PagesCtrl',
      abstract: true,
      template: "<ui-view></ui-view>",
      resolve: {
        isAdmin($auth){
          return $auth.validateUser().then(
            (success) => { return true; },
            (failure) => { return false; }
          ).then((bool) => { return bool; });
        },
        page(backend) {
          return backend.createPage(); }
      }
    })
    .state( 'root.inner.page.new', {
      url: 'new',
      templateUrl: 'pages/page-create.tpl.html',
      resolve: {
        onlyAdmin($auth){ return $auth.validateUser(); }
      },
      controller: 'PageNewCtrl'
    })
    .state( 'root.inner.page.show', {
      url: '*pageUrl',
      resolve: {
        pageLoaded(isAdmin, page, $stateParams){
          if(isAdmin){
            page.role = "admin";
          } else {
            page.role = "guest";
          }
          page.loadFromShortLink($stateParams.pageUrl);
          return page.complete;
        }
      },
      controller: 'PageShowCtrl',
      templateUrl: 'pages/pages.tpl.html'
    })

    .state( 'root.inner.page.edit', {
      templateUrl: 'pages/page-edit.tpl.html',
      controller: 'PageEditCtrl',
      resolve: {
        onlyAdmin($auth){ return $auth.validateUser(); }
        }
    });
});
