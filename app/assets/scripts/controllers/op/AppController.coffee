class Controller
  constructor: ($scope, $rootScope, $stateParams, $http, uploadService, appPackageService) ->
    $scope.lastApp = appPackageService.latest( -> $scope.app.version_code = $scope.lastApp.version_code + 1)
    $scope.app = new appPackageService


    upload = (file, callback)->
      return callback(undefined) if file is undefined
      $http.get('/ws/fileToken?bucket=suoqin-test').success (data)->
        uploadService.send file, data.token, (remoteFile) ->
          callback(remoteFile)

    $scope.doUpload = (pic) ->
      $scope.saving = true
      upload pic, (remoteFile) ->
        $scope.$apply ->
          $scope.app.url = remoteFile.url
          $scope.app.file_size = remoteFile.size
          console.log $scope.app
          $scope.app.$save()
          $scope.lastApp = appPackageService.latest ->
            $scope.app = new appPackageService
            $scope.app.version_code = $scope.lastApp.version_code + 1
            $scope.saving = false

    $scope.cleanFields = ->
      $scope.app = new appPackageService





angular.module('kulebaoOp').controller 'OpAppCtrl', ['$scope', '$rootScope',
                                                     '$stateParams', '$http',
                                                     'uploadService', 'appPackageService', Controller]

