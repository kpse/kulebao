'use strict'

class Controller
  constructor: ($rootScope, adminNewsService) ->
    @kindergarten =
      id: 1,
      name: 'school23'

    @adminUser =
      id: 1
      name: '豆瓣'

    $rootScope.tabName = 'bulletin'

    @newsletters = adminNewsService.bind(kg: @kindergarten.name, admin_id: @adminUser.id).query(() =>
      for news in @newsletters
        do (news) => news.readCount = 100
    )

    @publish = (news) =>
      news.pushlished = true
      news.$save(kg: @kindergarten.name, news_id: news.id)

    @hidden = (news) =>
      news.pushlished = false
      news.$save(kg: @kindergarten.name, news_id: news.id)

    @deleteNews = (news) =>
      news.$delete(kg: @kindergarten.name, news_id: news.id)
      @newsletters = @newsletters.filter (x) => x != news

    @createNews = () =>
      news = new adminNewsService({kg: @kindergarten.name, admin_id: @adminUser.id});
      news.title = "新通知";
      news.content = "新通知内容，点击进行编辑";
      news.$save(kg: @kindergarten.name, news_id: news.id);
      @newsletters.push news


angular.module('admin').controller 'BulletinManageCtrl', ['$rootScope','adminNewsService', Controller]
