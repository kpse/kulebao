'use strict'

class Controller
  constructor: ($stateParams, newsService) ->
    @kindergarten =
      id: 1,
      name: 'school23'
    @adminUser =
      id: 1
      name: '豆瓣'
    @readCount = 100
    @showEditBox = false
    @news = newsService.get(kg: @kindergarten.name, news_id: $stateParams.news)

    @backupContent = @news.content
    @startEditing = (e) =>
      @backupContent = @news.content
      e.stopPropagation()
      @showEditBox = true


    @cancelEditing = (e) =>
      e.stopPropagation()
      @news.content = @backupContent
      @showEditBox = false

    @save = (e) =>
      e.stopPropagation()
      @showEditBox = false
      @news.$save(kg: @kindergarten.name, news_id: @news.id) if(@backupContent != @news.content)

    @publish = (news) =>
      news.pushlished = true
      news.$save(kg: @kindergarten.name, news_id: @news.id)

    @hidden = (news) =>
      news.pushlished = false
      news.$save(kg: @kindergarten.name, news_id: @news.id)



angular.module(window.kulebaoApp).controller 'NewsEditCtrl', [ '$stateParams', 'newsService', Controller]