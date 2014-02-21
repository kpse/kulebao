'use strict'

conversationService = ($resource) ->
  $resource '/kindergarten/:school_id/conversation/:phone',
    {
      school_id: '@school_id'
      phone: '@phone'
    }

angular.module('kulebaoAdmin')
.factory('conversationService', ['$resource', conversationService])