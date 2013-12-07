app = angular.module "app", ['ui.router', 'ngResource', 'ngRoute']

app.config ($stateProvider, $urlRouterProvider) ->
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

  .state('kindergarten.wip',
      url: '/wip',
      template: '<div>Sorry, we are still in Building...</div><image src="assets/images/wip.gif"></image>'
    )

  $urlRouterProvider.otherwise ($injector, $location) ->
    path = $location.path()
    if path.indexOf("kindergarten", 0) < 0
    then $location.path '/kindergarten/school23'
    else $location.path path.replace /(kindergarten\/[^\/]+)\/.+$/g, '$1/wip'