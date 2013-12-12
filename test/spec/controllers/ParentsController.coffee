'use strict'

describe 'Controller: ParentsCtrl', () ->

  # load the controller's module
  beforeEach module 'kulebaoAdmin'

  ParentsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ParentsCtrl = $controller 'ParentsCtrl', {
      $scope: scope
    }

  it 'should attach a list of parents to the scope', () ->
    expect(scope.parents.length).toBe 5
