import {appName} from '../../src/common/config';

angular.module(`${appName}.testStates`, ['ui.router']).config([
    '$stateProvider',
    '$urlRouterProvider',
    function ($stateProvider, $urlRouterProvider){
        // For any unmatched url, redirect to /
        $urlRouterProvider.otherwise('/');

        $stateProvider
            .state('root', {
                abstract: true,
                template: '<ui-view/>'
            })
            .state('root.inner', {
                abstract: true,
                template: '<ui-view/>'
            });
    }
]);
