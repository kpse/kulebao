'use strict'

tokenService = ($http) ->
  $http({method: 'GET', url:'/ws/fileToken?bucket=suoqin-test'})


uploadService = () ->
  send: (file, token, successCallback) ->
    data = new FormData()
    xhr = new XMLHttpRequest()

    xhr.onloadend = (e) ->
      response = JSON.parse(e.currentTarget.response)
      successCallback({
      url: "http://suoqin-test.u.qiniudn.com/" + response.name
      size: response.size
      })



    # Send to server, where we can then access it with $_FILES['file].
    data.append "file", file
    data.append "token", token
    xhr.open "POST", "http://up.qiniu.com"
    xhr.send data

angular.module('kulebaoAdmin')
.factory('tokenService', ['$http', tokenService])
.factory('uploadService', uploadService)

angular.module('kulebaoAdmin').directive "fileChange", ->
  linker = ($scope, element) ->

    # onChange, push the files to $scope.files.
    element.bind "change", (event) ->
      $scope.file = event.target.files[0]
      $scope.$apply( -> $scope.app.size = $scope.file.size)


  restrict: "A"
  link: linker
