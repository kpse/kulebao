'use strict'

class Controller
  constructor: (newsService, readService) ->
    @kindergarten =
      id: 1,
      name: 'school23'

    @user =
      id: 1
      name: '豆瓣'

    @newsletters = newsService.bind(kg: @kindergarten.name).query()
    @readNews = readService.bind(kg: @kindergarten.name, parent_id: @user.id).query

    @markRead = (id) -> readService.markRead(parent_id: @user.id, kg: @kindergarten.name, news_id: id)

angular.module('app').controller 'BulletinCtrl', ['newsService', 'readService', Controller]
