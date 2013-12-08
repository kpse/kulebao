'use strict'

class Controller
  constructor: (newsService, readService) ->
    @kindergarten =
      id: 1,
      name: 'school23'

    @adminUser =
      id: 1
      name: '豆瓣'

    @newsletters = newsService.bind(kg: @kindergarten.name).query(() =>
      for news in @newsletters
        do (news) => news.readCount = 100
    )


angular.module('admin').controller 'BulletinManageCtrl', ['newsService', 'readService', Controller]
