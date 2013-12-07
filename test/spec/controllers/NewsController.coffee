'use strict'

describe 'Controller: NewsCtrl', () ->

  # load the controller's module
  beforeEach module 'app'

  NewsCtrl = {}
  scope = {}
  $httpBackend = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, _$httpBackend_) ->
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET('/kindergarten/school23/news/999')
    .respond(
        {
          id: 999
          title: 't'
          content: '321'
          issueDate: '1990-10-01'
        }
    )
    $httpBackend.expectGET('/kindergarten/school23/parent/1/news')
    .respond [
        {
          id: 1
          k_id: 1
          parent_id: 1
          news_id: 1
          readTime: '1990-10-01'
        }     ,
        {
          id: 2
          k_id: 1
          parent_id: 1
          news_id: 2
          readTime: '1990-10-01'
        }
      ]
    NewsCtrl = $controller 'NewsCtrl', {
      $stateParams:
        news: 999,
    }

  it 'should have 2 news from request', () ->
#    expect(NewsCtrl.news).toBeUndefined()
    $httpBackend.flush()
    expect(NewsCtrl.news.id).toBe 999
