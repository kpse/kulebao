'use strict'

angular.module('kulebaoAdmin')
.controller 'NewsEditCtrl',
    [ '$scope', '$stateParams', 'newsService', '$location', 'GroupMessage', 'schoolService', '$modal',
      (scope, $stateParams, newsService, $location, GroupMessage, School, Modal) ->
        scope.kindergarten = School.get school_id: $stateParams.kindergarten, ->
          scope.news = newsService.get(school_id: scope.kindergarten.school_id, news_id: $stateParams.news)

        scope.adminUser =
          id: 1
          name: '豆瓣'

        scope.showEditBox = false

        scope.startEditing = (e) ->
          scope.backupContent = angular.copy scope.news.content
          e.stopPropagation()
          scope.showEditBox = true

        scope.cancelEditing = (e) ->
          e.stopPropagation()
          angular.copy(scope.backupContent, scope.news.content)
          scope.showEditBox = false

        scope.save = (e) ->
          e.stopPropagation()
          scope.showEditBox = false
          scope.news.$save(school_id: scope.kindergarten.school_id, news_id: scope.news.news_id) if(scope.backupContent != scope.news.content)

        scope.publish = (news) ->
          news.pushlished = true
          news.$save(school_id: scope.kindergarten.school_id, news_id: news.news_id)
          msg = new GroupMessage
          msg.school_id = parseInt(scope.kindergarten.school_id)
          msg.news_id = news.news_id
          msg.$save()

        scope.hidden = (news) ->
          news.pushlished = false
          news.$save(school_id: scope.kindergarten.school_id, news_id: news.news_id)

        scope.editingTitle = false
        scope.backupTitle = {}

        scope.saveTitle = (e) ->
          e.stopPropagation()
          scope.editingTitle = false
          scope.news.$save(school_id: scope.kindergarten.school_id, news_id: scope.news.news_id) if(scope.backupTitle != scope.news.title)

        scope.startEditingTitle = (e) ->
          e.stopPropagation()
          scope.backupTitle = angular.copy scope.news.title
          scope.editingTitle = true

        scope.deleteMe = () ->
          scope.news.$delete(school_id: scope.kindergarten.school_id, news_id: scope.news.news_id)
          $location.path("/kindergarten/" + scope.kindergarten.school_id + "/bulletin");

    ]

angular.module('kulebaoAdmin').controller 'AddNewsCtrl',
  ['$scope', '$rootScope', '$location', 'adminNewsService',
   '$stateParams', 'GroupMessage', 'schoolService',
    (scope, $rootScope, $location, adminNewsService, $stateParams, GroupMessage, School) ->
      scope.adminUser =
        id: 1
        name: '学校某老师'

      scope.kindergarten = School.get school_id: $stateParams.kindergarten, ->
        if $rootScope.editingNews is undefined
          scope.news = new adminNewsService
            school_id: scope.kindergarten.school_id
            admin_id: scope.adminUser.id
        else
          scope.news = $rootScope.editingNews
          delete $rootScope.editingNews

      scope.save = (news) ->
        news.$save ->
          scope.$hide()
          scope.$emit 'refreshNews'

      scope.publish = (news) ->
        news.published = true
        news.$save ->
          scope.$emit 'refreshNews'

  ]