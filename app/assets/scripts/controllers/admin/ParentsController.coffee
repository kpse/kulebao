'use strict'

angular.module('kulebaoAdmin')
.controller 'ParentsCtrl', ($scope, $rootScope) ->
    $rootScope.tabName = 'parents'

    $scope.parents = [
      {name: '袋鼠', phone: 13234567889, id: 1, child: '小袋鼠'},
      {name: '熊猫', phone: 13234567890, id: 2, child: '小熊猫'},
      {name: '鸵鸟', phone: 13234567891, id: 3, child: '小鸟'},
      {name: '鸭嘴兽', phone: 13234567892, id: 4, child: '卵'},
      {name: '大象', phone: 13234567893, id: 5, child: '小象'}
    ]
    $scope.editingId = -1
    $scope.backupEditing = {}
    $scope.add = () ->
      lastParent = _.max($scope.parents, (p) -> p.id)
      $scope.parents.push {name: '新人', phone: 98765432001, id: (lastParent.id + 1), child: '小新人'}

    $scope.delete = (parent) ->
      $scope.parents = _.reject($scope.parents, (p) -> parent.id == p.id )

    $scope.startEditing = (parent) ->
      $scope.editingId = parent.id
      $scope.backupEditing = angular.copy $scope.parents

    $scope.save = () ->
      $scope.editingId = -1

    $scope.cancelEditing = () ->
      $scope.editingId = -1
      angular.copy $scope.backupEditing, $scope.parents

angular.module('kulebaoAdmin')
.controller 'AddParentCtrl', ($scope) ->
    @createNewParent = (previousId) =>
      {name: '新人', phone: 98765432001, id: (previousId + 1), child: '小新人'}

    $scope.lastParent = _.max($scope.parents, (p) -> p.id)
    $scope.parent = @createNewParent($scope.lastParent.id)

    $scope.save = (parent) =>
      $scope.parents.push parent
      $scope.parent = @createNewParent(parent.id)


