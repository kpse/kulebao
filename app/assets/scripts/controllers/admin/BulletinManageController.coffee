'use strict'

class Controller
  constructor: (newsService, readService) ->
    @kindergarten =
      id: 1,
      name: 'school23'

    @user =
      id: 1
      name: '豆瓣'

    @newsletters = newsService.bind(kg: @kindergarten.name).query(() =>
      @readNews = readService.bind(kg: @kindergarten.name, parent_id: @user.id).query(() =>
        @determineReadOrNot(@readNews, @newsletters, @user)
      ))

    @determineReadOrNot = (readNews, newsletters, user) ->
      for news in readNews
        do (news) ->
          for n in (newsletters.filter (n) -> n.id == news.news_id and news.parent_id == user.id)
            do (n) -> n.read = true


angular.module('admin').controller 'BulletinManageCtrl', ['newsService', 'readService', Controller]
