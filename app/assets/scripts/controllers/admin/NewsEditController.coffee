'use strict'

class Controller
  constructor: ($stateParams, newsService, $location) ->
    @kindergarten =
      id: 1,
      name: 'school23'
    @adminUser =
      id: 1
      name: '豆瓣'
    @readCount = 100
    @news = newsService.get(kg: @kindergarten.name, news_id: $stateParams.news)

    @showEditBox = false

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
      news.$save(kg: @kindergarten.name, news_id: news.id)

    @hidden = (news) =>
      news.pushlished = false
      news.$save(kg: @kindergarten.name, news_id: news.id)

    @editingTitle = false
    @backupTitle = @news.title

    @saveTitle = (e) =>
      e.stopPropagation()
      @editingTitle = false
      @news.$save(kg: @kindergarten.name, news_id: @news.id) if(@backupTitle != @news.title)

    @startEditingTitle = (e) =>
      e.stopPropagation()
      @backupTitle = @news.title
      @editingTitle = true

    @deleteMe = () =>
      @news.$delete(kg: @kindergarten.name, news_id: @news.id)
      $location.path("/kindergarten/" + @kindergarten.name + "/bulletin");


angular.module(window.kulebaoApp).controller 'NewsEditCtrl', [ '$stateParams', 'newsService', '$location', Controller]