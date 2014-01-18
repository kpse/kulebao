'use strict'

angular.module('kulebaoAdmin')
.controller 'ParentsCtrl',
    ['$scope', '$rootScope', '$stateParams', '$location', 'schoolService', 'classService', 'parentService',
      ($scope, $rootScope, $stateParams, $location, School, Class, Parent) ->
        $rootScope.tabName = 'parents'
        $scope.kindergarten = School.get school_id: $stateParams.kindergarten, ->
          $scope.kindergarten.classes = Class.bind({school_id: $stateParams.kindergarten}).query ->
            $location.path($location.path() + '/class/' + $scope.kindergarten.classes[0].class_id + '/list') if $location.path().indexOf("/class/", 0) < 0

        $scope.newParent = () ->
          $rootScope.parent = new Parent
            school_id: parseInt($scope.kindergarten.school_id)
            birthday: '1980-1-1'
            gender: 1
            portrait: '/assets/images/portrait_placeholder.png'
            name: '马大帅'
            card: ''
            kindergarten: $scope.kindergarten.school_info
            relationship: '妈妈'
            child:
              birthday: '2009-1-1'
              gender: 1
              portrait: '/assets/images/portrait_placeholder.png'
              class_id: 0
          $rootScope.parentChanged = true
          $location.path($location.path().replace(/\/[^\/]+$/, '/edit_adult'))
    ]

angular.module('kulebaoAdmin')
.controller 'EditParentCtrl',
    ['$scope', '$rootScope', '$location', 'classService', 'cardService', '$stateParams',
    ($scope, $rootScope, $location, Class, Card, stateParams) ->
      $scope.backToList = () ->
        $location.path($location.path().replace(/\/[^\/]+$/, '/list'))

      if $rootScope.parent isnt undefined
        $scope.parent = $rootScope.parent
        $scope.parent.child.class_id = parseInt(stateParams.classId)
        $scope.kindergarten.classes = Class.bind(school_id: $scope.parent.kindergarten.school_id).query()
        $scope.allCards = Card.bind(school_id: $scope.parent.kindergarten.school_id).query ->
          $scope.allCards = _.reject $scope.allCards, (c) -> c.phone is $scope.parent.phone
      else
        $scope.backToList()

      $scope.cancelCreating = ->
        $rootScope.parentChanged = false
        $scope.backToList()
        delete $rootScope.parent

      $scope.getClassName = (id) ->
        _.find $scope.kindergarten.classes, (c)-> c.class_id is id;

      $scope.isDuplicated = (card) ->
        return false if card is undefined || card.length < 10
        undefined isnt _.find $scope.allCards, (c) ->
          c.card_id == card

      $scope.backToParent = ->
        window.history.back()
    ]

angular.module('kulebaoAdmin')
.controller 'ParentsInClassCtrl',
    ['$scope', '$rootScope', 'parentService', '$stateParams', '$location', '$http', 'uploadService', '$timeout', 'schoolService', 'classService',
      ($scope, $rootScope, Parent, $stateParams, $location, $http, uploadService, $timeout, School, Class) ->
        $scope.loading = true
        $scope.current_class = parseInt($stateParams.classId)
        $scope.kindergarten = School.get school_id: $stateParams.kindergarten, ->
          $scope.parents = Parent.bind(school_id: $scope.kindergarten.school_id, class_id: $stateParams.classId).query()
          $scope.kindergarten.classes = Class.bind({school_id: $stateParams.kindergarten}).query ->
            $scope.loading = false
            $location.path($location.path() + '/class/' + $scope.kindergarten.classes[0].class_id + '/list') if $location.path().indexOf("/class/", 0) < 0

        $scope.delete = (parent) ->
          $scope.parents = _.reject($scope.parents, (p) ->
            parent.id == p.id)
          parent.$delete()

        $rootScope.parentChanged = false

        $scope.startEditing = (parent) ->
          $scope.loading = true
          $rootScope.parent = parent
          $rootScope.$watch 'parent', (oldv, newv) ->
            $rootScope.parentChanged = true if newv isnt oldv
          , true
          $location.path $location.path().replace(/\/[^\/]+$/, '/edit_adult')


        $scope.backToList = ->
          $scope.loading = false
          $scope.saving = false
          $location.path($location.path().replace(/\/[^\/]+$/, '/list'))

        upload = (file, callback)->
          return callback(undefined) if file is undefined
          $http.get('/ws/fileToken?bucket=suoqin-test').success (data)->
            uploadService.send file, data.token, (remoteFile) ->
              callback(remoteFile.url)

        $scope.save = (parent) ->
          $scope.saving = true
          console.log 'parent changed: ' + $rootScope.parentChanged
          if $rootScope.parentChanged
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