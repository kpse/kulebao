'use strict'

angular.module('kulebaoAdmin')
.controller 'ParentsCtrl',
    ['$scope', '$rootScope', 'parentService', '$stateParams', '$location', ($scope, $rootScope, Parent, $stateParams, $location) ->
      $rootScope.tabName = 'parents'

      $scope.kindergarten = {
        school_id: $stateParams.kindergarten
      }
      $scope.parents = Parent.bind({school_id: $scope.kindergarten.school_id}).query()


      $scope.delete = (parent) ->
        $scope.parents = _.reject($scope.parents, (p) ->
          parent.id == p.id)
        parent.$delete()

      $scope.startEditing = (parent) ->
        $rootScope.parent = parent
        $location.path($location.path().replace(/\/[^\/]+$/, '/edit_adult'))

      $scope.newParent = () ->
        $rootScope.parent = new Parent(
          school_id: parseInt($scope.kindergarten.school_id)
          birthday: new Date(10123123123)
          gender: 1
          portrait: '/assets/images/portrait_placeholder.png'
          name: '马大帅'
          kindergarten:
            name: '石家庄火车站幼儿园'
            school_id: 93740362
          relationship: '妈妈'
          child:
            birthday: new Date(931153123123)
            gender: 1
            portrait: '/assets/images/portrait_placeholder.png'
            class_id: 101
        )
        $location.path($location.path().replace(/\/[^\/]+$/, '/edit_adult'))

      $scope.backToList = () -> $location.path($location.path().replace(/\/[^\/]+$/, '/list'))

      $scope.save = (parent) ->
        parent.$save()
        $scope.parents = Parent.bind({school_id: $scope.kindergarten.school_id}).query( -> $scope.backToList())

    ]

angular.module('kulebaoAdmin')
.controller 'EditParentCtrl',
    ['$scope', '$rootScope', '$location', ($scope, $rootScope, $location) ->
      $scope.backToList = () -> $location.path($location.path().replace(/\/[^\/]+$/, '/list'))

      if $rootScope.parent isnt undefined
        $scope.parent = $rootScope.parent
      else
        $scope.backToList()

      $scope.cancelCreating = ->
        $scope.backToList()
        delete $rootScope.parent

      $scope.kindergarten.classes = [
        {name: '西瓜班', id: 100},
        {name: '核桃班', id: 101}
      ]
    ]