class Controller
  constructor: ($scope, $rootScope, $stateParams, $http, uploadService, appPackageService) ->
    $scope.lastApp = new appPackageService
    $scope.app = new appPackageService

    $scope.uploadme = {};
    $scope.uploadme.src = ''

    $scope.doUpload = ->
      $http.get('/ws/fileToken?bucket=suoqin-test').success( (data)->
        $scope.token = data.token
        uploadService.send($scope.file, $scope.token, (remoteFile) ->
          $scope.app.url = remoteFile.url
          $scope.app.size = remoteFile.size
          console.log $scope.app
          $scope.app.$save()
        )
      )




angular.module('kulebaoOp').controller 'OpAppCtrl', ['$scope', '$rootScope',
                                                     '$stateParams', '$http',
                                                     'uploadService', 'appPackageService', Controller]

