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


angular.module('kulebaoApp', ['ui.router', 'ngResource', 'ngRoute'])
angular.module('kulebaoAdmin', ['kulebaoApp', 'ui.router', 'ngResource', 'ngRoute', 'ui.bootstrap', 'ui.mask', '$strap.directives'])
angular.module('kulebaoOp', ['kulebaoAdmin', 'kulebaoApp', 'ui.router', 'ngResource', 'ngRoute', 'ui.bootstrap', 'ui.mask', '$strap.directives'])
.config ['$stateProvider', '$urlRouterProvider', Config]
