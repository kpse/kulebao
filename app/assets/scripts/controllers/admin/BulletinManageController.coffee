'use strict'

angular.module('kulebaoAdmin').controller 'BulletinManageCtrl',
  ['$scope', '$rootScope', '$location', 'adminNewsService',
   '$stateParams', 'GroupMessage', 'schoolService', '$modal'
    (scope, $rootScope, $location, adminNewsService, $stateParams, GroupMessage, School, Modal) ->
      $rootScope.tabName = 'bulletin'

      scope.loading = true
      scope.adminUser =
        id: 1
        name: '学校某老师'

      scope.kindergarten = School.get school_id: $stateParams.kindergarten, ->
        scope.newsletters = adminNewsService.bind(school_id: scope.kindergarten.school_id, admin_id: scope.adminUser.id).query ->
          scope.loading = false

      scope.publish = (news) ->
        news.pushlished = true
        news.$save(school_id: scope.kindergarten.school_id, news_id: news.news_id, admin_id: scope.adminUser.id)
        msg = new GroupMessage
        msg.school_id = parseInt(scope.kindergarten.school_id)
        msg.news_id = news.news_id
        msg.$save()

      scope.hidden = (news) ->
        news.pushlished = false
        news.$save(school_id: scope.kindergarten.school_id, news_id: news.news_id, admin_id: scope.adminUser.id)

      scope.deleteNews = (news) ->
        news.$delete(school_id: scope.kindergarten.school_id, news_id: news.news_id, admin_id: scope.adminUser.id)
        scope.newsletters = scope.newsletters.filter (x) ->
          x != news

      scope.createNews =  ->
        scope.currentModal = Modal scope: scope, contentTemplate: 'templates/admin/add_news.html'

      scope.edit = (news) ->
        $rootScope.editingNews = news
        scope.currentModal = Modal
          scope: scope
          contentTemplate: 'templates/admin/add_news.html'

      scope.$on 'refreshNews', ->
        scope.loading = true
        scope.newsletters = adminNewsService.bind(school_id: scope.kindergarten.school_id, admin_id: scope.adminUser.id).query ->
          scope.loading = false
  ]