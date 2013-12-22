'use strict'

angular.module('kulebaoAdmin')
  .service 'GroupMessage', ['$resource', ($resource) ->
    $resource('/ws/broadcast')
  ]