'use strict'

describe 'Directive: ngConfirmClick', () ->

  # load the directive's module
  beforeEach module 'admin'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    scope.p = 1
    scope.kill = () -> scope.p = 0

  beforeEach ->
    @confirmStub = window.confirm
    window.confirm = (a) -> true

  afterEach ->
    window.confirm = @confirmStub


  it 'should process after confirmation', inject ($compile) ->
    element = angular.element '<button ng-confirm-msg="really?" ng-confirm-click="kill()"></button>'
    element = $compile(element) scope
    element.click()
    expect(scope.p).toBe 0

  it 'should block without confirmation', inject ($compile) ->
    window.confirm = (a) -> false

    element = angular.element '<button ng-confirm-msg="really?" ng-confirm-click="kill()"></button>'
    element = $compile(element) scope
    element.click()
    expect(scope.p).toBe 1
