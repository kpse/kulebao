class Controller
  constructor: ($scope, $rootScope, $stateParams, $http, uploadService, appPackageService) ->
    $scope.lastApp = appPackageService.latest( -> $scope.app.version_code = $scope.lastApp.version_code + 1)
    $scope.app = new appPackageService


    $scope.uploadme = {};
    $scope.uploadme.src = ''

    $scope.doUpload = ->
      $http.get('/ws/fileToken?bucket=suoqin-test').success( (data)->
        $scope.token = data.token
        uploadService.send($scope.file, $scope.token, (remoteFile) ->
          $scope.app.url = remoteFile.url
          $scope.app.file_size = remoteFile.size
          console.log $scope.app
          $scope.app.$save()
          $scope.lastApp = appPackageService.latest( ->
            $scope.app = new appPackageService
            $scope.app.version_code = $scope.lastApp.version_code + 1)
        )

      )




angular.module('kulebaoOp').controller 'OpAppCtrl', ['$scope', '$rootScope',
                                                     '$stateParams', '$http',
                                                     'uploadService', 'appPackageService', Controller]

