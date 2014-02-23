'use strict'

relationshipService = ($resource) ->
  $resource '/kindergarten/:school_id/relationship/:card',
    {
      school_id: '@school_id'
      card: '@card'
    }

angular.module('kulebaoAdmin')
.factory('relationshipService', ['$resource', relationshipService])