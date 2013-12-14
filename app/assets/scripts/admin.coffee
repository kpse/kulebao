class Config
  constructor: ($stateProvider, $urlRouterProvider) ->
    $stateProvider
    .state('kindergarten',
        url: '/kindergarten/:kindergarten',
        templateUrl: 'templates/admin/kindergarten_manage.html',
        controller: 'KgManageCtrl'
      )
    .state('kindergarten.bulletin',
        url: '/bulletin',
        templateUrl: 'templates/admin/bulletin_manage.html',
        controller: 'BulletinManageCtrl'
      )
    .state('kindergarten.news',
        url: '/news/:news',
        templateUrl: 'templates/admin/news_edit.html',
        controller: 'NewsEditCtrl'
      )
    .state('kindergarten.parents',
        url: '/parents',
        templateUrl: 'templates/admin/parents.html',
        controller: 'ParentsCtrl'
      )

    .state('kindergarten.wip',
        url: '/wip',
        template: '<div>Sorry, we are still in Building...</div><image class="img-responsive" src="assets/images/wip.gif"></image>',
        controller: 'WipCtrl'
      )

    $urlRouterProvider.otherwise ($injector, $location) ->
      path = $location.path()
      if path.indexOf("kindergarten", 0) < 0
      then $location.path '/kindergarten/school23'
      else $location.path path.replace /(kindergarten\/[^\/]+)\/.+$/g, '$1/wip'


angular.module('kulebaoApp', ['ui.router', 'ngResource', 'ngRoute'])
angular.module('kulebaoAdmin', ['kulebaoApp', 'ui.router', 'ngResource', 'ngRoute', 'ui.bootstrap', 'ui.mask'])
.config ['$stateProvider', '$urlRouterProvider', Config]
