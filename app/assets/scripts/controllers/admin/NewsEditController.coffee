'use strict'

class Controller
  constructor: ($stateParams, newsService, $location) ->
    @kindergarten =
      id: 1,
      name: '93740362'
      school_id: 93740362
    @adminUser =
      id: 1
      name: '豆瓣'
    @readCount = 100
    @news = newsService.get(school_id: @kindergarten.school_id, news_id: $stateParams.news)

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
      @news.$save(school_id: @kindergarten.school_id, news_id: @news.news_id) if(@backupContent != @news.content)

    @publish = (news) =>
      news.pushlished = true
      news.$save(school_id: @kindergarten.school_id, news_id: news.news_id)

    @hidden = (news) =>
      news.pushlished = false
      news.$save(school_id: @kindergarten.school_id, news_id: news.news_id)

    @editingTitle = false
    @backupTitle = @news.title

    @saveTitle = (e) =>
      e.stopPropagation()
      @editingTitle = false
      @news.$save(school_id: @kindergarten.school_id, news_id: @news.news_id) if(@backupTitle != @news.title)

    @startEditingTitle = (e) =>
      e.stopPropagation()
      @backupTitle = @news.title
      @editingTitle = true

    @deleteMe = () =>
      @news.$delete(school_id: @kindergarten.school_id, news_id: @news.news_id)
      $location.path("/kindergarten/" + @kindergarten.school_id + "/bulletin");


angular.module('kulebaoAdmin').controller 'NewsEditCtrl', [ '$stateParams', 'newsService', '$location', Controller]