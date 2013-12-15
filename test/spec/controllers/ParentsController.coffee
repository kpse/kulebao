'use strict'

describe 'Controller: ParentsCtrl', () ->

  # load the controller's module
  beforeEach module 'kulebaoAdmin'

  ParentsCtrl = {}
  scope = {}
  $httpBackend = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, parentService, _$httpBackend_) ->
    scope = $rootScope.$new()
    ParentsCtrl = $controller 'ParentsCtrl', {
      $scope: scope
      parentService: parentService
    }
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET('/kindergarten/school23/parent')
    .respond(
        [{
          id: 1
          name: 'name'
          school_id: 1
          phone: 123
        }])

  it 'should attach a list of parents to the scope', () ->
    $httpBackend.flush()
    expect(scope.parents.length).toBe 1
