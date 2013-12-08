'use strict'

class Controller
  constructor: ($rootScope) ->
    $rootScope.tabName = 'wip'


angular.module(window.kulebaoApp).controller 'WipCtrl', [ '$rootScope', Controller]