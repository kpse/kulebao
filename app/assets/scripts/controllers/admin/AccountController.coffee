'use strict'

angular.module('kulebaoAdmin')
.controller 'AccountCtrl', ['$scope', '$resource', '$rootScope', '$http', ($scope, $resource, $rootScope, $http) ->
    $rootScope.tabName = 'swipingcard'

    Account = $resource '/kindergarten/:school_id/account/:accountId',
      {
        school_id: 93740362
        accountId: '@accountId'
      }
    $scope.accounts = Account.query()

    $scope.sendMessage = (account) ->
      $http({method: 'POST', url: '/ws/swipe', data: account}).success((data) ->
        alert('error_code:' + data.error_code))
  ]