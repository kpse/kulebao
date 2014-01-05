'use strict'

angular.module('kulebaoAdmin')
.controller 'ParentsCtrl', ['$scope', '$rootScope', 'parentService', '$stateParams', ($scope, $rootScope, parentService, $stateParams) ->
    $rootScope.tabName = 'parents'

    $scope.kindergarten = {
      school_id: $stateParams.kindergarten
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

angular.module('kulebaoAdmin')
.controller 'AddAdultInfoCtrl', ['$scope', 'parentService', '$timeout', ($scope, Parent, $timeout) ->
    $scope.parent = new Parent({school_id: $scope.kindergarten.name})
    $scope.parent.birthday = new Date
    $scope.parent.gender = 1
    $scope.parent.portrait = '/assets/images/portrait_placeholder.png'
  ]

angular.module('kulebaoAdmin')
.controller 'AddChildInfoCtrl', ['$scope', 'parentService', '$timeout', ($scope, Parent, $timeout) ->
    $scope.child =
      relationship: '妈妈'
      gender : 1
      portrait : '/assets/images/portrait_placeholder.png'
  ]
