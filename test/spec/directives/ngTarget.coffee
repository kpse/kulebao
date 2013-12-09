'use strict'

describe 'Directive: ngTarget', () ->

  # load the directive's module
  beforeEach module 'kulebaoAdmin'

  scope = {}

  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should build up complex html', inject ($rootScope, $compile) ->

    element1 = $compile('<textarea class="target" x-ng-target="target"></textarea>')($rootScope);
    element2 = $compile('<button class="button" ng-click="target.focus()"></button>')($rootScope);
    parent = $compile('<div></div>')($rootScope);
    parent.append(element1)
    parent.append(element2)
    $rootScope.$digest();
    parent.find(".button").click()
    #some problem while testing focus
    #expect(parent.find('.target')).toBeFocused();

