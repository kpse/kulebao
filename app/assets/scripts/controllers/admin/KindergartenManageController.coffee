class Controller
  constructor: ($rootScope, $stateParams) ->
    @kindergarten =
      school_id: $stateParams.kindergarten
      desc: '成都市第二十三幼儿园'

    @adminUser =
      id: 1
      name: '豆瓣老师'

    @isSelected = (tab)->
      tab == $rootScope.tabName

angular.module('kulebaoAdmin').controller 'KgManageCtrl', ['$rootScope', '$stateParams', Controller]