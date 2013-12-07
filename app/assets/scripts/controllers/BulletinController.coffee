'use strict'

class Controller
  constructor: (@newsService) ->
    @newsletters = @newsService.get()
    @kindergarten =
      id: 1,
      name: 'school23'


angular.module('app').controller 'BulletinCtrl', ['newsService', Controller]
