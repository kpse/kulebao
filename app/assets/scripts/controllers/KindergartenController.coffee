class Controller
  constructor: ($rootScope) ->
    @kindergarten =
      name: 'school23'
      desc: '成都市第二十三幼儿园'
    @user =
      id: 1
      name: '豆瓣'

    @isSelected = (tab)->
      tab == $rootScope.tabName


angular.module(window.kulebaoApp).controller 'KindergartenCtrl', ['$rootScope', Controller]