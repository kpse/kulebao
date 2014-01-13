'use strict'

cardService = ($resource) ->
  $resource '/kindergarten/:school_id/card/:card_id',
    {
      school_id: '@school_id'
      card_id: '@card_id'
    }

angular.module('kulebaoAdmin')
.factory('cardService', ['$resource', cardService])