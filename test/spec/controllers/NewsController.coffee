'use strict'

describe 'Controller: NewsCtrl', () ->

  # load the controller's module
  beforeEach module 'app'

  NewscontrollerCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    NewscontrollerCtrl = $controller 'NewsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
