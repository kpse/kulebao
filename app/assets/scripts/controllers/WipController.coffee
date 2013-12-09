'use strict'

class Controller
  constructor: ($rootScope) ->
    $rootScope.tabName = 'wip'


angular.module('kulebaoApp').controller 'WipCtrl', [ '$rootScope', Controller]