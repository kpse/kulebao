'use strict'

class Controller
  constructor: ($stateParams, newsService, readService) ->
    @kindergarten =
      id: 1
      name: '93740362'
      school_id: 93740362
    @user =
      id: '1'
      name: '豆瓣'
    readService.markRead(parent_id: @user.id, school_id: @kindergarten.school_id, news_id: $stateParams.news)
    @news = newsService.get(school_id: @kindergarten.school_id, news_id: $stateParams.news)


angular.module('kulebaoApp').controller 'NewsCtrl', [ '$stateParams', 'newsService', 'readService', Controller]