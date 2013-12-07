'use strict'

class Controller
  constructor: ($stateParams, @newsService) ->
    @news = @newsService.getNews($stateParams.news)[0]

angular.module('app').controller 'NewsCtrl', [ '$stateParams', 'newsService', Controller]