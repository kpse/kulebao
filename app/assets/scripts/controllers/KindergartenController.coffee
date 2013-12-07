class Controller
  constructor: () ->
    @kindergarten =
      name: 'school23'
      desc: '成都市第二十三幼儿园'
    @user =
      name: '豆瓣'

angular.module('app').controller 'KindergartenCtrl', Controller