class Config
  constructor: ($stateProvider, $urlRouterProvider) ->
    $stateProvider
    .state 'main',
      url: '/main',
      templateUrl: 'templates/op/main.html',
      controller: 'OpCtrl'
    .state 'main.app',
      url: '/app',
      templateUrl: 'templates/op/app.html',
      controller: 'OpAppCtrl'
    .state 'main.school',
      url: '/school',
      templateUrl: 'templates/op/school.html',
      controller: 'OpSchoolCtrl'
    .state 'main.feedback',
      url: '/feedback',
      templateUrl: 'templates/op/feedback.html',
      controller: 'OpFeedbackCtrl'

    $urlRouterProvider.otherwise ($injector, $location) ->
      $location.path '/main/app'


angular.module('kulebaoApp', ['ui.router', 'ngResource', 'ngRoute', 'angulartics', 'angulartics.google.analytics'])
angular.module('kulebaoAdmin', ['kulebaoApp', 'ui.router', 'ngResource', 'ngRoute', 'ui.bootstrap', 'ui.mask', 'angulartics', 'angulartics.google.analytics'])
angular.module('kulebaoOp', ['kulebaoAdmin', 'kulebaoApp', 'ui.router', 'ngResource', 'ngRoute', 'ui.bootstrap', 'ui.mask', 'angulartics', 'angulartics.google.analytics'])
.config ['$stateProvider', '$urlRouterProvider', Config]
