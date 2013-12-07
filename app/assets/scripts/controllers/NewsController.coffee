'use strict'

class Controller
  constructor: ($stateParams, newsService, readService) ->
    @kindergarten =
      id: 1,
      name: 'school23'
    @user =
      id: 1
      name: '豆瓣'
    @news = newsService.get(kg: @kindergarten.name, news_id: $stateParams.news)
    @readNews = readService.bind(kg: @kindergarten.name, parent_id: @user.id).query()
    _.each(_.intersection(@readNews, @news), (news)->
      news.read = true;
    )

angular.module('app').controller 'NewsCtrl', [ '$stateParams', 'newsService', 'readService', Controller]