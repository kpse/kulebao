'use strict'

class Controller
  constructor: ($rootScope, newsService, readService) ->
    @kindergarten =
      id: 1,
      name: '93740362'

    @user =
      id: 1
      name: '豆瓣'

    $rootScope.tabName = 'bulletin'

    @newsletters = newsService.bind(kg: @kindergarten.name).query(() =>
      @readNews = readService.bind(kg: @kindergarten.name, parent_id: @user.id).query(() =>
        @determineReadOrNot(@readNews, @newsletters, @user)
      ))

    @determineReadOrNot = (readNews, newsletters, user) ->
      _.each(newsletters, (news) -> news.read = false)
      for news in readNews
        do (news) ->
          for n in (newsletters.filter (n) -> n.id == news.news_id and news.parent_id == user.id)
            do (n) -> n.read = true


angular.module('kulebaoApp').controller 'BulletinCtrl', ['$rootScope', 'newsService', 'readService', Controller]
