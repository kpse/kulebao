'use strict'

describe 'Controller: BulletinCtrl', () ->

  # load the controller's module
  beforeEach module 'kulebaoApp'

  BulletinCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    BulletinCtrl = $controller 'BulletinCtrl', {
      $scope: scope
    }

  it 'should distinguish news which has already been read', () ->
    readnews = [
      {parent_id: 1, news_id: 2}
    ]
    news = [
      {news_id: 1},
      {news_id: 2}
    ]
    user = id: 1
    BulletinCtrl.determineReadOrNot(readnews, news, user)
    expect(news[1].read).toBeTruthy()

  it 'should distinguish news which has already been read', () ->
    readnews = [
      {parent_id: 2, news_id: 1},
      {parent_id: 2, news_id: 2}
    ]
    news = [
      {news_id: 1},
      {news_id: 2}
    ]
    user = id: 2

    BulletinCtrl.determineReadOrNot(readnews, news, user)

    expect(news[0].read).toBeTruthy()
    expect(news[1].read).toBeTruthy()

  it 'should consider news is unread by default', () ->
    readnews = []
    news = [
      {news_id: 1},
      {news_id: 2}
    ]
    user = id: 1

    BulletinCtrl.determineReadOrNot(readnews, news, user)

    expect(news[0].read).toBe false
    expect(news[1].read).toBe false