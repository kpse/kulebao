'use strict'

describe 'Controller: NewsCtrl', () ->

  # load the controller's module
  beforeEach module 'kulebaoApp'

  NewsCtrl = {}
  $httpBackend = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, _$httpBackend_) ->
    $httpBackend = _$httpBackend_
    $httpBackend.expectPOST('/kindergarten/93740362/parent/1/news/999')
    .respond(
        {
          id: 999
          school_id: 93740362
          parent_id: 1
          news_id: 2
          readTime: '1990-10-01'
        }
      )
    $httpBackend.expectGET('/kindergarten/93740362/news/999')
    .respond(
        {
          id: 999
          school_id: 93740362
          parent_id: 1
          news_id: 1
          readTime: '1990-10-01'
        })
    NewsCtrl = $controller 'NewsCtrl', {
      $stateParams:
        news: 999
        kindergarten: 93740362
    }

  it 'should have 2 news from request', () ->
    $httpBackend.flush()
    expect(NewsCtrl.news.id).toBe 999
