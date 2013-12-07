'use strict'

angular.module('app')
.controller 'BulletinCtrl', ($scope) ->
    $scope.newsletters = [
      {title: '新闻1', content: '缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知', read: false},
      {title: '新闻2', content: '缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知', read: false},
      {title: '新闻3', content: '缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知', read: false}
    ]
