angular.module( 'LRNewWebsite.pages', [
  'ui.router.state'
])

.config(function config( $stateProvider ) {
  $stateProvider.state( 'pages', {
    url: '/pages/:id',
    views: {
      "main": {
        controller: 'PagesCtrl',
        templateUrl: 'pages/pages.tpl.html'
      }
    },
    data:{ pageTitle: 'Awesome' }
  });
})

.controller( 'PagesCtrl', function AboutCtrl( $scope ) {
  // This is simple a demo for UI Boostrap.
  $scope.dropdownDemoItems = [
    "The first choice!",
    "And another choice for you.",
    "but wait! A third!"
  ];
})

;
