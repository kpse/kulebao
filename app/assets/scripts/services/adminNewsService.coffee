'use strict'

adminNewsService = ($resource) ->
  $resource '/kindergarten/:school_id/admin/:admin_id/news/:news_id',
    {
      school_id: '@school_id'
      admin_id: '@admin_id'
      news_id: '@news_id'
    }


angular.module('kulebaoAdmin')
.factory('adminNewsService', ['$resource', adminNewsService])
