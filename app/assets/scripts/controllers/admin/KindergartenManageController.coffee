class Controller
  constructor: () ->
    @kindergarten =
      name: 'school23'
      desc: '成都市第二十三幼儿园'

    @adminUser =
      id: 1
      name: '豆瓣老师'

angular.module('admin').controller 'KgManageCtrl', Controller