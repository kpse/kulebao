'use strict'

angular.module('kulebaoAdmin')
.controller 'ParentsCtrl', ['$scope', '$rootScope', 'parentService', ($scope, $rootScope, parentService) ->
    $rootScope.tabName = 'parents'

    $scope.kindergarten = {
      name: '93740362'
      school_id: 93740362
    }
    $scope.parents = parentService.bind({school_id: $scope.kindergarten.school_id}).query()

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

angular.module('kulebaoAdmin').value '$strapConfig', { datepicker: language: 'en', format: 'yyyy-mm-dd' }



angular.module('kulebaoAdmin')
.controller 'AddParentCtrl', ['$scope', 'parentService', '$timeout', ($scope, Parent, $timeout) ->
    $scope.parent = new Parent({school_id: $scope.kindergarten.name})
    $scope.parent.birthday = new Date
    $scope.parent.gender = 1

    $scope.save = (parent) =>
      parent.$save(()->
        $scope.parents = Parent.bind({school_id: $scope.kindergarten.school_id}).query()
      )
      $scope.parents.push parent
      $scope.parent = new Parent({school_id: $scope.kindergarten.school_id})

  ]
