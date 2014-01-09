'use strict'

angular.module('kulebaoAdmin')
.controller 'IntroCtrl', [ '$scope', '$rootScope', '$stateParams', '$location', 'schoolService', '$http', 'uploadService', '$timeout'
  (scope, rootScope, stateParams, location, School, $http, uploadService, $timeout) ->
    scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
      scope.school = scope.kindergarten.school_info

      scope.$watch 'kindergarten', (oldv, newv) ->
          scope.school_changed = true if newv isnt oldv
        , true

    scope.school_changed = false
    scope.isEditing = false

    rootScope.tabName = 'intro'
    scope.toggleEditing = (e) ->
      e.stopPropagation()
      scope.isEditing = !scope.isEditing
      console.log 'scope.school changed: ' + scope.school_changed
      if scope.school_changed
        $timeout ->
            scope.kindergarten.$save()
            scope.school_changed = false;
          , 0, true

    upload = (file, callback)->
      return callback(undefined) if file is undefined
      $http.get('/ws/fileToken?bucket=suoqin-test').success (data)->
        uploadService.send file, data.token, (remoteFile) ->
          callback(remoteFile.url)

    scope.uploadPic = (pic) ->
      upload pic, (url) ->
        scope.$apply ->
          scope.school.school_logo_url = url if url isnt undefined

]
