'use strict'

class Controller
  constructor: ($rootScope, $location, adminNewsService) ->
    @kindergarten =
      id: 1,
      name: '93740362'
      school_id: 93740362

    @adminUser =
      id: 1
      name: '豆瓣'

    $rootScope.tabName = 'bulletin'

    @newsletters = adminNewsService.bind(school_id: @kindergarten.school_id, admin_id: @adminUser.id).query(() =>
      for news in @newsletters
        do (news) => news.readCount = 100
    )

    @publish = (news) =>
      news.pushlished = true
      news.$save(school_id: @kindergarten.school_id, news_id: news.news_id, admin_id: @adminUser.id)

    @hidden = (news) =>
      news.pushlished = false
      news.$save(school_id: @kindergarten.school_id, news_id: news.news_id, admin_id: @adminUser.id)

    @deleteNews = (news) =>
      news.$delete(school_id: @kindergarten.school_id, news_id: news.news_id, admin_id: @adminUser.id)
      @newsletters = @newsletters.filter (x) => x != news

    @createNews = () =>
      news = new adminNewsService({school_id: @kindergarten.school_id, admin_id: @adminUser.id});
      news.title = "新通知";
      news.content = "新通知内容，点击进行编辑";
      news.$save(school_id: @kindergarten.school_id, news_id: news.news_id);
      @newsletters.push news

    @edit = (news) =>
      $location.path('/kindergarten/' + @kindergarten.school_id + '/news/' + news.news_id )


angular.module('kulebaoAdmin').controller 'BulletinManageCtrl', ['$rootScope', '$location', 'adminNewsService', Controller]
