'use strict'

angular.module('kulebaoAdmin')
.controller 'ParentsCtrl',
    ['$scope', '$rootScope', 'parentService', '$stateParams', '$location', '$http', 'uploadService',
      ($scope, $rootScope, Parent, $stateParams, $location, $http, uploadService) ->
        $rootScope.tabName = 'parents'

        $scope.kindergarten =
          school_id: $stateParams.kindergarten

        $scope.parents = Parent.bind({school_id: $scope.kindergarten.school_id}).query()


        $scope.delete = (parent) ->
          $scope.parents = _.reject($scope.parents, (p) ->
            parent.id == p.id)
          parent.$delete()

        $scope.startEditing = (parent) ->
          $rootScope.parent = parent
          $location.path $location.path().replace(/\/[^\/]+$/, '/edit_adult')

        $scope.newParent = () ->
          $rootScope.parent = new Parent
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

          $location.path($location.path().replace(/\/[^\/]+$/, '/edit_adult'))

        $scope.backToList = ->
          $location.path($location.path().replace(/\/[^\/]+$/, '/list'))

        upload = (file, callback)->
          return callback(undefined) if file is undefined
          $http.get('/ws/fileToken?bucket=suoqin-test').success (data)->
            uploadService.send file, data.token, (remoteFile) ->
              callback(remoteFile.url)

        $scope.save = (parent, childPic) ->
          upload childPic, (child_p_url) ->
            $scope.$apply ->
              parent.child.portrait = child_p_url if child_p_url isnt undefined
              parent.$save ->
                $scope.parents = Parent.bind({school_id: $scope.kindergarten.school_id}).query ->
                  $scope.backToList()


        $scope.nextPage = (parent, parentPic) ->
          upload parentPic, (parent_p_url) ->
            $scope.$apply ->
              parent.portrait = parent_p_url if parent_p_url isnt undefined
          $location.path($location.path().replace(/\/[^\/]+$/, '/edit_child'))

        $scope.preview = (parent, childPic) ->
          upload childPic, (child_p_url) ->
            $scope.$apply ->
              parent.child.portrait = child_p_url if child_p_url isnt undefined
    ]

angular.module('kulebaoAdmin')
.controller 'EditParentCtrl',
    ['$scope', '$rootScope', '$location', ($scope, $rootScope, $location) ->
      $scope.backToList = () ->
        $location.path($location.path().replace(/\/[^\/]+$/, '/list'))

      if $rootScope.parent isnt undefined
        $scope.parent = $rootScope.parent
      else
        $scope.backToList()

      $scope.cancelCreating = ->
        $scope.backToList()
        delete $rootScope.parent

      $scope.kindergarten.classes = [
        {name: '西瓜班', id: 100},
        {name: '核桃班', id: 101},
        {name: '菠萝班', id: 777888},
        {name: '鬼畜班', id: 777999}
      ]
    ]