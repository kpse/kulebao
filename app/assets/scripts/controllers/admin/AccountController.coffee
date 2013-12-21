'use strict'

angular.module('kulebaoAdmin')
.controller 'AccountCtrl', ['$scope', '$resource', '$rootScope', '$http', '$stateParams', ($scope, $resource, $rootScope, $http, $stateParams) ->
    $rootScope.tabName = 'swipingcard'

    Account = $resource '/kindergarten/:school_id/account/:accountId',
      {
        school_id: $stateParams.kindergarten
        accountId: '@accountId'
      }
    $scope.accounts = Account.query()

    $scope.sendMessage = (account) ->
      $http({method: 'POST', url: '/ws/swipe', data: account}).success((data) ->
        alert('error_code:' + data.error_code))
  ]