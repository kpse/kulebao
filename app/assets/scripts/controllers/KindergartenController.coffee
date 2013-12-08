class Controller
  constructor: () ->
    @kindergarten =
      name: 'school23'
      desc: '成都市第二十三幼儿园'
    @user =
      id: 1
      name: '豆瓣'

angular.module(window.kulebaoApp).controller 'KindergartenCtrl', Controller