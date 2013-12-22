class Controller
  constructor: ($scope, $rootScope, $stateParams) ->
    $scope.app =
      summary: '测试版本'
      url: 'http://cocobabys.oss-cn-hangzhou.aliyuncs.com/app_release/release_2.apk'
      size: 50000
      version: 'V1.1'
      versioncode: 2

angular.module('kulebaoOp').controller 'OpAppCtrl', ['$scope', '$rootScope', '$stateParams', Controller]