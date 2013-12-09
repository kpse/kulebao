'use strict'

describe 'Controller: WipcontrollerCtrl', () ->

  # load the controller's module
  beforeEach module 'kulebaoApp'

  WipcontrollerCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    WipcontrollerCtrl = $controller 'WipCtrl', {
      $scope: scope
    }

  it 'should clean tab name', () ->
    expect(scope.tabName).toBe 'wip'
