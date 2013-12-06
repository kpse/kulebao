app = angular.module "app", ['ui.router', 'ngResource', 'ngRoute']

app.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
  .state('kindergarten',
      url: '/kindergarten/:kindergarten',
      templateUrl: 'templates/kindergarten.html',
      controller: 'KindergartenCtrl'
    )

  .state('kindergarten.wip',
      url: '/wip',
      template: '<div>Sorry, we are still in Building...</div>'
    )

  $urlRouterProvider.otherwise ($injector, $location) ->
    path = $location.path()
    if path.indexOf "kindergarten" < 0
    then $location.path '/kindergarten/jiaotong'
    else $location.path path.replace /(kindergarten\/[^\/]+)\/.+$/g, '$1/wip'


app.controller 'KindergartenCtrl',
  class kgCtrl
    init: ($scope, $stateParams) ->
      $scope.kindergarten =
        name: '成都市第二十三幼儿园'
      $scope.user =
        name: '豆瓣'
      $scope.userName = '豆瓣'