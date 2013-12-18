class Controller
  constructor: ($rootScope) ->
    @kindergarten =
      name: '93740362'
      desc: '成都市第二十三幼儿园'

    @adminUser =
      id: 1
      name: '豆瓣老师'

    @isSelected = (tab)->
      tab == $rootScope.tabName

angular.module('kulebaoAdmin').controller 'KgManageCtrl', ['$rootScope', Controller]