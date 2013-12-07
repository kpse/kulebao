'use strict'

describe 'Controller: NewsCtrl', () ->

  # load the controller's module
  beforeEach module 'app'

  NewsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    NewsCtrl = $controller 'NewsCtrl', {
      $stateParams : news: 2,
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(NewsCtrl.news.id).toBe 2
