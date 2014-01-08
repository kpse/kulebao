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
        url: "http://suoqin-test.u.qiniudn.com/" + response.hash
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


angular.module('kulebaoAdmin').directive "fileupload", ->
  link: (scope, element, attributes) ->

    element.bind "change", (e) ->
      scope.$apply ->
        scope[attributes.fileupload] = e.target.files[0]
        scope.app.file_size = e.target.files[0].size if scope.app isnt undefined
