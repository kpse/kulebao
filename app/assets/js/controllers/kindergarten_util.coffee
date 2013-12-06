class KindergartenCtrl
  @$inject: ['$scope']
  constructor: (@scope) ->
    @scope.kindergarten =
      name: 'school23'
      desc: '成都市第二十三幼儿园'
    @scope.user =
      name: '豆瓣'

angular.module('app').controller 'KindergartenCtrl', KindergartenCtrl