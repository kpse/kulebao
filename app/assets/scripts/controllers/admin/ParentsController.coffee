'use strict'

angular.module('kulebaoAdmin')
.controller 'ParentsCtrl', ($scope, $rootScope) ->
    $rootScope.tabName = 'parents'

    $scope.parents = [
      {name: '袋鼠', phone: '1234567889', id: 1, child: '小袋鼠'},
      {name: '熊猫', phone: '1234567890', id: 2, child: '小熊猫'},
      {name: '鸵鸟', phone: '1234567891', id: 3, child: '小鸟'},
      {name: '鸭嘴兽', phone: '1234567892', id: 4, child: '卵'},
      {name: '大象', phone: '1234567893', id: 5, child: '小象'}
    ]

    $scope.add = () ->
      lastParent = _.max($scope.parents, (p) -> p.id)
      $scope.parents.push {name: '新人', phone: '1111111111', id: (lastParent.id + 1), child: '小新人'}

    $scope.delete = (parent) ->
      $scope.parents = _.reject($scope.parents, (p) -> parent.id == p.id )

    $scope.startEditing = (e) ->
      e.stopPropagation()
      $scope.showEditBox = true

    $scope.save = (e) ->
      e.stopPropagation()
      $scope.showEditBox = false