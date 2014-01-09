class Controller
  constructor: ($rootScope, $stateParams, School) ->

    @kindergarten = School.get school_id: $stateParams.kindergarten

    @adminUser =
      id: 1
      name: '豆瓣老师'

    @isSelected = (tab)->
      tab == $rootScope.tabName

angular.module('kulebaoAdmin').controller 'KgManageCtrl', ['$rootScope', '$stateParams', 'schoolService', Controller]