'use strict'

describe 'Directive: ngConfirmClick', () ->

  # load the directive's module
  beforeEach module 'kulebaoApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<ng-confirm-click></ng-confirm-click>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the ngConfirmClick directive'
