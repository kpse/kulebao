'use strict'

class Controller
  constructor: ($stateParams, newsService, $location, GroupMessage, School) ->

    @kindergarten = School.get school_id: $stateParams.kindergarten, =>
      @news = newsService.get(school_id: @kindergarten.school_id, news_id: $stateParams.news)

    @adminUser =
      id: 1
      name: '豆瓣'

    @showEditBox = false

    @startEditing = (e) =>
      @backupContent = angular.copy @news.content
      e.stopPropagation()
      @showEditBox = true

    @cancelEditing = (e) =>
      e.stopPropagation()
      angular.copy(@backupContent, @news.content)
      @showEditBox = false

    @save = (e) =>
      e.stopPropagation()
      @showEditBox = false
      @news.$save(school_id: @kindergarten.school_id, news_id: @news.news_id) if(@backupContent != @news.content)

    @publish = (news) =>
      news.pushlished = true
      news.$save(school_id: @kindergarten.school_id, news_id: news.news_id)
      msg = new GroupMessage
      msg.school_id = parseInt(@kindergarten.school_id)
      msg.news_id = news.news_id
      msg.$save()

    @hidden = (news) =>
      news.pushlished = false
      news.$save(school_id: @kindergarten.school_id, news_id: news.news_id)

    @editingTitle = false
    @backupTitle = {}

    @saveTitle = (e) =>
      e.stopPropagation()
      @editingTitle = false
      @news.$save(school_id: @kindergarten.school_id, news_id: @news.news_id) if(@backupTitle != @news.title)

    @startEditingTitle = (e) =>
      e.stopPropagation()
      @backupTitle = angular.copy @news.title
      @editingTitle = true

    @deleteMe = () =>
      @news.$delete(school_id: @kindergarten.school_id, news_id: @news.news_id)
      $location.path("/kindergarten/" + @kindergarten.school_id + "/bulletin");


angular.module('kulebaoAdmin').controller 'NewsEditCtrl', [ '$stateParams', 'newsService', '$location', 'GroupMessage', 'schoolService', Controller]