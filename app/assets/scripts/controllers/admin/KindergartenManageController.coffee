class Controller
  constructor: (scope, $rootScope, $stateParams, School, location) ->

    @kindergarten = School.get school_id: $stateParams.kindergarten

    @adminUser =
      id: 1
      name: '豆瓣老师'

    @isSelected = (tab)->
      tab is $rootScope.tabName

    scope.goParents = ->
      if location.path().indexOf("parents/class") < 0
        location.path('/kindergarten/' + $stateParams.kindergarten + '/parents')
      else
        location.path(location.path().replace(/\/[^\/]+$/, '/list'))

angular.module('kulebaoAdmin').controller 'KgManageCtrl', ['$scope', '$rootScope', '$stateParams', 'schoolService', '$location', Controller]