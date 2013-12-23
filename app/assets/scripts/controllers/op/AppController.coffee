class Controller
  constructor: ($scope, $rootScope, $stateParams, $http, uploadService) ->
    $scope.app =
      summary: '测试版本'
      url: 'http://cocobabys.oss-cn-hangzhou.aliyuncs.com/app_release/release_2.apk'
      size: 50000
      version: 'V1.1'
      versioncode: 2
      remote_url: ''

    $scope.uploadme = {};
    $scope.uploadme.src = ''

    $http.get('/ws/fileToken?bucket=suoqin-test').success( (data)-> $scope.token = data.token)

    $scope.doUpload = ->
      uploadService.send($scope.file, $scope.token, (remoteFile) ->
        $scope.app.url = remoteFile
        console.log $scope.app
      )



angular.module('kulebaoOp').controller 'OpAppCtrl', ['$scope', '$rootScope', '$stateParams', '$http', 'uploadService', Controller]

