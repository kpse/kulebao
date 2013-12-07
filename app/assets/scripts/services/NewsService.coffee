'use strict'

window.kulebaoServices = {} if (window.kulebaoServices is undefined)


window.kulebaoServices.newsService = ($resource) ->
  $resource '/kindergarten/:kg/news/:news_id',
    {
      kg: '@kg'
      news_id: '@news_id'
    }
window.kulebaoServices.readService = ($resource) ->
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
