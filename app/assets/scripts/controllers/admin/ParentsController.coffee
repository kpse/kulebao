'use strict'

angular.module('kulebaoAdmin')
.controller 'ParentsCtrl',
    ['$scope', '$rootScope', 'parentService', '$stateParams', ($scope, $rootScope, parentService, $stateParams) ->
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
.controller 'AddAdultInfoCtrl',
    ['$scope', 'parentService', '$rootScope', '$location', ($scope, Parent, $rootScope, $location) ->
      if $rootScope.parent isnt undefined
        $scope.parent = $rootScope.parent
      else
        $scope.parent = new Parent(
          school_id: $scope.kindergarten.school_id
          birthday: new Date(10123123123)
          gender: 1
          portrait: '/assets/images/portrait_placeholder.png'
          name: '马大帅'
          kindergarten:
            name: '石家庄火车站幼儿园'
            school_id: 93740362
          relationship: '妈妈'
        )
        $rootScope.parent = $scope.parent

      $scope.cancelCreating = ->
        $scope.backToList()
        delete $rootScope.parent

      $scope.backToList = () -> $location.path($location.path().replace(/\/[^\/]+$/, '/list'))
    ]

angular.module('kulebaoAdmin')
.controller 'AddChildInfoCtrl',
    ['$scope', 'parentService', '$rootScope', '$location', 'childService',
      ($scope, Parent, $rootScope, $location, Child) ->

        $scope.backToList = () -> $location.path($location.path().replace(/\/[^\/]+$/, '/list'))

        if $rootScope.parent is undefined
          $scope.backToList()
        else if $rootScope.parent.child is undefined
          $rootScope.parent.child = new Child(
            birthday: new Date(931153123123)
            gender: 1
            portrait: '/assets/images/portrait_placeholder.png'
            class_id: 101
            school_id: parseInt($rootScope.parent.kindergarten.school_id)
          )

        $scope.kindergarten.classes = [
          {name: '西瓜班', id: 100},
          {name: '核桃班', id: 101}
        ]

        $scope.getClassName = (id) ->
          _.find($scope.kindergarten.classes, (c)->
            c.id is id);

        $scope.cancelCreating = ->
          $scope.backToList()
          delete $rootScope.parent

        $scope.save = (parent) ->
          parent.$save(() ->
            $scope.cancelCreating())


    ]
