class Controller
  constructor: ($scope, $rootScope, $stateParams) ->

    $scope.adminUser =
        id: 99
        name: '内务大总管'

    $scope.isSelected = (tab)->
      tab == $rootScope.tabName

angular.module('kulebaoOp').controller 'OpCtrl', ['$scope', '$rootScope', '$stateParams', Controller]