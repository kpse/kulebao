'use strict'

angular.module('app')
.factory 'newsService',
    ['$resource',
      ($resource) ->
        $resource '/kindergarten/:kg/news/:news_id',
          {
            kg: '@kg'
            news_id: '@news_id'
          }
    ]
.factory 'readService',
    ['$resource',
      ($resource) ->
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
    ]