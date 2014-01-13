'use strict'

describe 'Controller: ParentsCtrl', () ->

  # load the controller's module
  beforeEach module 'kulebaoAdmin'

  ParentsCtrl = {}
  scope = {}
  $httpBackend = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, classService, schoolService, _$httpBackend_) ->
    scope = $rootScope.$new()
    ParentsCtrl = $controller 'ParentsInClassCtrl', {
      $scope: scope
      $rootScope: $rootScope
      classService: classService
      schoolService: schoolService
      $stateParams:
        kindergarten: 93740362
    }
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET('/kindergarten/93740362')
    .respond
        school_id: 93740362
        name: 'school_name'

    $httpBackend.expectGET('/kindergarten/93740362/parent?')
    .respond [
            id: 1
            name: 'name'
            school_id: 1
            phone: 123
        ]
    $httpBackend.expectGET('/kindergarten/93740362/class')
    .respond              [
        class_id: 123
        name: 'class_name'
      ]

  it 'should attach a list of parents to the scope', () ->
    $httpBackend.flush()
    expect(scope.parents.length).toBe 1
