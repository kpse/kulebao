class Config
  constructor: ($stateProvider, $urlRouterProvider) ->
    $stateProvider
    .state('kindergarten',
        url: '/kindergarten/:kindergarten',
        templateUrl: 'templates/kindergarten.html',
        controller: 'KindergartenCtrl'
      )
    .state('kindergarten.bulletin',
        url: '/bulletin',
        templateUrl: 'templates/bulletin.html',
        controller: 'BulletinCtrl'
      )
    .state('kindergarten.news',
        url: '/news/:news',
        templateUrl: 'templates/news.html',
        controller: 'NewsCtrl'
      )

    .state('kindergarten.wip',
        url: '/wip',
        template: '<div>Sorry, we are still in Building...</div><image class="img-responsive" src="assets/images/wip.gif"></image>',
        controller: 'WipCtrl'
      )

    $urlRouterProvider.otherwise ($injector, $location) ->
      path = $location.path()
      if path.indexOf("kindergarten", 0) < 0
      then $location.path '/kindergarten/93740362'
      else $location.path path.replace /(kindergarten\/[^\/]+)\/.+$/g, '$1/wip'

angular.module('kulebaoApp', ['ui.router', 'ngResource', 'ngRoute']).config ['$stateProvider', '$urlRouterProvider', Config]
