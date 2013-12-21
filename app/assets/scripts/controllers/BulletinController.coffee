'use strict'

class Controller
  constructor: ($rootScope, newsService, readService, $stateParams) ->
    @kindergarten =
      school_id: $stateParams.kindergarten

    @user =
      id: '1'
      name: '豆瓣'

    $rootScope.tabName = 'bulletin'

    @newsletters = newsService.bind(school_id: @kindergarten.school_id).query(() =>
      @readNews = readService.bind(school_id: @kindergarten.school_id, parent_id: @user.id).query(() =>
        @determineReadOrNot(@readNews, @newsletters, @user)
      ))

    @determineReadOrNot = (readNews, newsletters, user) ->
      _.each(newsletters, (news) -> news.read = false)
      for news in readNews
        do (news) ->
          for n in (newsletters.filter (n) -> n.news_id == news.news_id and news.parent_id == user.id)
            do (n) -> n.read = true


angular.module('kulebaoApp').controller 'BulletinCtrl', ['$rootScope', 'newsService', 'readService', '$stateParams', Controller]
