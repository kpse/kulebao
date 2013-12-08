'use strict'

describe 'Directive: ngTarget', () ->

  # load the directive's module
  beforeEach module 'app'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<ng-target></ng-target>'
    element = $compile(element) scope
#    expect(element.text()).toBe 'this is the ngTarget directive'
