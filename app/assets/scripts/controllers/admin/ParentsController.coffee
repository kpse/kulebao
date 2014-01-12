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

        $rootScope.parent_changed = false

        $scope.startEditing = (parent) ->
          $rootScope.parent = parent
          $rootScope.$watch 'parent', (oldv, newv) ->
              $rootScope.parent_changed = true if newv isnt oldv
            , true
          $location.path $location.path().replace(/\/[^\/]+$/, '/edit_adult')


        $scope.newParent = () ->
          $rootScope.parent = new Parent
            school_id: parseInt($scope.kindergarten.school_id)
            birthday: '1980-1-1'
            gender: 1
            portrait: '/assets/images/portrait_placeholder.png'
            name: '马大帅'
            card: '1234567890'
            kindergarten: $scope.kindergarten.school_info
            relationship: '妈妈'
            child:
              birthday: '2009-1-1'
              gender: 1
              portrait: '/assets/images/portrait_placeholder.png'
              class_id: 777666
          $rootScope.parent_changed = true
          $location.path($location.path().replace(/\/[^\/]+$/, '/edit_adult'))

        $scope.backToList = ->
          $location.path($location.path().replace(/\/[^\/]+$/, '/list'))

        upload = (file, callback)->
          return callback(undefined) if file is undefined
          $http.get('/ws/fileToken?bucket=suoqin-test').success (data)->
            uploadService.send file, data.token, (remoteFile) ->
              callback(remoteFile.url)

        $scope.save = (parent) ->
          console.log 'parent changed: ' + $rootScope.parent_changed
          if $rootScope.parent_changed
            $timeout ->
                parent.$save ->
                  $scope.parents = Parent.bind({school_id: $scope.kindergarten.school_id}).query ->
                    $scope.backToList()
              , 0, true
          else
            $scope.backToList()


        $scope.nextPage = ->
          $location.path($location.path().replace(/\/[^\/]+$/, '/edit_child'))

        $scope.uploadPic = (person, pic) ->
          upload pic, (url) ->
            $scope.$apply ->
              person.portrait = url if url isnt undefined

        generateCheckingInfo = (parent) ->
          school_id: parseInt($stateParams.kindergarten)
          card_no: parent.card
          card_type: 0
          notice_type: 2
          record_url: 'http://suoqin-test.u.qiniudn.com/FoUJaV4r5L0bM0414mGWEIuCLEdL'
          timestamp: new Date().getTime()

        $scope.sendMessage = (parent) ->
          check = generateCheckingInfo(parent)
          $http({method: 'POST', url: '/kindergarten/'+$stateParams.kindergarten+'/check', data: check}).success (data) ->
            alert 'error_code:' + data.error_code

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
        $rootScope.parent_changed = false
        $scope.backToList()
        delete $rootScope.parent

      $scope.getClassName = (id) ->
        _.find $scope.kindergarten.classes, (c)-> c.class_id is id;

    ]