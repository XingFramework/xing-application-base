import {Config} from 'a1atscript';

@Config(['$stateProvider'])
export default function PagesStates( $stateProvider ) {
  $stateProvider

    .state( 'root.inner.page', {
      url: '^/pages/',
      controller: 'PagesCtrl',
      abstract: true,
      template: "<ui-view lrd-state-attrs></ui-view>",
      resolve: {
        isAdmin: ['$auth', function ($auth){
          return $auth.validateUser().then(
            (success) => { return true; },
            (failure) => { return false; }
          ).then((bool) => { return bool; });
        } ],
        page: [ 'backend', function(backend) {
          return backend.createPage();
        } ]
      }
    })
    .state( 'root.inner.page.new', {
      url: 'new',
      templateUrl: 'pages/page-create.tpl.html',
      resolve: {
        onlyAdmin: [ '$auth', function($auth){ return $auth.validateUser(); } ]
      },
      controller: 'PageNewCtrl'
    })
    .state( 'root.inner.page.show', {
      url: '*pageUrl',
      resolve: {
        pageLoaded: [ 'isAdmin', 'page', '$stateParams', function(isAdmin, page, $stateParams){
          if(isAdmin){
            page.role = "admin";
          } else {
            page.role = "guest";
          }
          page.loadFromShortLink($stateParams.pageUrl);
          return page.complete;
        }
      ] } ,
      controller: 'PageShowCtrl',
      templateUrl: 'pages/pages.tpl.html'
    })

    .state( 'root.inner.page.edit', {
      templateUrl: 'pages/page-edit.tpl.html',
      controller: 'PageEditCtrl',
      resolve: {
        onlyAdmin: [ '$auth', function($auth){ return $auth.validateUser(); } ]
      }
    });
}
