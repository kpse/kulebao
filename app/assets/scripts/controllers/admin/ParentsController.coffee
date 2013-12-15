'use strict'

angular.module('kulebaoAdmin')
.controller 'ParentsCtrl', ['$scope', '$rootScope', 'parentService', ($scope, $rootScope, parentService) ->
    $rootScope.tabName = 'parents'

    $scope.kindergarten = {
      name: 'school23'
    }
    $scope.parents = parentService.bind({kg: $scope.kindergarten.name}).query()

    $scope.editingId = -1
    $scope.backupEditing = {}

    $scope.delete = (parent) ->
      $scope.parents = _.reject($scope.parents, (p) ->
        parent.id == p.id)
      parent.$delete()

    $scope.startEditing = (parent) ->
      $scope.editingId = parent.id
      $scope.backupEditing = angular.copy $scope.parents

    $scope.save = (parent) ->
      $scope.editingId = -1
      parent.$save()

    $scope.cancelEditing = () ->
      $scope.editingId = -1
      angular.copy $scope.backupEditing, $scope.parents
  ]

angular.module('kulebaoAdmin')
.controller 'AddParentCtrl', ['$scope', 'parentService', ($scope, Parent) ->
    $scope.parent = new Parent({kg: $scope.kindergarten.name})

    $scope.save = (parent) =>
      parent.$save(()->
        $scope.parents = Parent.bind({kg: $scope.kindergarten.name}).query()
      )
      $scope.parents.push parent
      $scope.parent = new Parent({kg: $scope.kindergarten.name})

  ]

