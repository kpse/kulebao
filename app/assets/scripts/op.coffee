class Config
  constructor: ($stateProvider, $urlRouterProvider) ->
    $stateProvider
    .state('main',
        url: '/main',
        templateUrl: 'templates/op/main.html',
        controller: 'OpCtrl'
      )
    .state('main.app',
        url: '/app',
        templateUrl: 'templates/op/app.html',
        controller: 'OpAppCtrl'
      )

    $urlRouterProvider.otherwise ($injector, $location) ->
      $location.path '/main/app'


angular.module('kulebaoApp', ['ui.router', 'ngResource', 'ngRoute', 'angulartics', 'angulartics.google.analytics'])
angular.module('kulebaoAdmin', ['kulebaoApp', 'ui.router', 'ngResource', 'ngRoute', 'ui.bootstrap', 'ui.mask', '$strap.directives', 'angulartics', 'angulartics.google.analytics'])
angular.module('kulebaoOp', ['kulebaoAdmin', 'kulebaoApp', 'ui.router', 'ngResource', 'ngRoute', 'ui.bootstrap', 'ui.mask', '$strap.directives', 'angulartics', 'angulartics.google.analytics'])
.config ['$stateProvider', '$urlRouterProvider', Config]
