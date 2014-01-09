'use strict'

angular.module('kulebaoAdmin')
.controller 'ParentsCtrl',
    ['$scope', '$rootScope', 'parentService', '$stateParams', '$location', '$http', 'uploadService', '$timeout', 'schoolService',
      ($scope, $rootScope, Parent, $stateParams, $location, $http, uploadService, $timeout, School) ->
        $rootScope.tabName = 'parents'

        $scope.kindergarten = School.get school_id: $stateParams.kindergarten, ->
          $scope.parents = Parent.bind({school_id: $scope.kindergarten.school_id}).query()

        $scope.delete = (parent) ->
          $scope.parents = _.reject($scope.parents, (p) ->
            parent.id == p.id)
          parent.$delete()

        $scope.parent_changed = false

        $scope.startEditing = (parent) ->
          $rootScope.parent = parent
          $location.path $location.path().replace(/\/[^\/]+$/, '/edit_adult')
          $rootScope.$watchCollection 'parent', (oldv, newv) ->
              $scope.parent_changed = true if newv isnt undefined


        $scope.newParent = () ->
          $rootScope.parent = new Parent
            school_id: parseInt($scope.kindergarten.school_id)
            birthday: new Date(10123123123)
            gender: 1
            portrait: '/assets/images/portrait_placeholder.png'
            name: '马大帅'
            card: '1234567890'
            kindergarten:
              name: '成都市第三军区幼儿园'
              school_id: 93740362
            relationship: '妈妈'
            child:
              birthday: new Date(931153123123)
              gender: 1
              portrait: '/assets/images/portrait_placeholder.png'
              class_id: 777666
          $scope.parent_changed = true
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
            $timeout () ->
                parent.child.portrait = child_p_url if child_p_url isnt undefined
                console.log 'parent changed: ' + $scope.parent_changed
                parent.$save ->
                  $scope.parents = Parent.bind({school_id: $scope.kindergarten.school_id}).query ->
                    $scope.backToList()
              , 0, true


        $scope.nextPage = (parent, parentPic) ->
          upload parentPic, (parent_p_url) ->
            $timeout () ->
                parent.portrait = parent_p_url if parent_p_url isnt undefined
              , 0, true
          $location.path($location.path().replace(/\/[^\/]+$/, '/edit_child'))

        $scope.preview = (parent, childPic) ->
          upload childPic, (child_p_url) ->
            $timeout () ->
                parent.child.portrait = child_p_url if child_p_url isnt undefined
              , 0, true
    ]

angular.module('kulebaoAdmin')
.controller 'EditParentCtrl',
    ['$scope', '$rootScope', '$location', 'classService', ($scope, $rootScope, $location, Class) ->

      $scope.backToList = () ->
        $location.path($location.path().replace(/\/[^\/]+$/, '/list'))

      if $rootScope.parent isnt undefined
        $scope.parent = $rootScope.parent
        $scope.kindergarten.classes = Class.bind({school_id: $scope.parent.kindergarten.school_id}).query()
      else
        $scope.backToList()

      $scope.cancelCreating = ->
        $scope.parent_changed = false
        $scope.backToList()
        delete $rootScope.parent


    ]