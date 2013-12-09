'use strict'



newsService = ($resource) ->
  $resource '/kindergarten/:kg/news/:news_id',
    {
      kg: '@kg'
      news_id: '@news_id'
    }
readService = ($resource) ->
  $resource '/kindergarten/:kg/parent/:parent_id/news/:news_id',
    {
      kg: '@kg'
      news_id: '@news_id'
      parent_id: '@parent_id'
    },
    {
      markRead:
        method: 'POST'
    }
readingStatService = ($resource) ->
  $resource '/kindergarten/:kg/admin/:admin_id/news_reading_count/:news_id',
    {
      kg: '@kg'
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