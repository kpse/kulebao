'use strict'

describe 'Controller: BulletinCtrl', () ->

  # load the controller's module
  beforeEach module 'app'

  BulletinCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    BulletinCtrl = $controller 'BulletinCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
