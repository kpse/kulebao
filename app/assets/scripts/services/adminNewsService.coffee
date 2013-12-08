'use strict'

adminNewsService = ($resource) ->
  $resource '/kindergarten/:kg/admin/:admin_id/news/:news_id',
    {
      kg: '@kg'
      admin_id: '@admin_id'
      news_id: '@news_id'
    }


angular.module('admin')
.factory('adminNewsService', ['$resource', adminNewsService])
