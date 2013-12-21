'use strict'



newsService = ($resource) ->
  $resource '/kindergarten/:school_id/news/:news_id',
    {
      school_id: '@school_id'
      news_id: '@news_id'
    }
readService = ($resource) ->
  $resource '/kindergarten/:school_id/parent/:parent_id/news/:news_id',
    {
      school_id: '@school_id'
      news_id: '@news_id'
      parent_id: '@parent_id'
    },
    {
      markRead:
        method: 'POST'
    }
readingStatService = ($resource) ->
  $resource '/kindergarten/:school_id/admin/:admin_id/news_reading_count/:news_id',
    {
      school_id: '@school_id'
      news_id: '@news_id'
      admin_id: '@admin_id'
    },
    {
      readingCount: method: 'GET'
    }


angular.module('kulebaoApp')
.factory('newsService', ['$resource', newsService])
.factory('readService', ['$resource', readService])
.factory('readingStatService', ['$resource', readingStatService])