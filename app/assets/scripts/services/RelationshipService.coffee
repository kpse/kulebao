'use strict'

relationshipService = ($resource) ->
  $resource '/kindergarten/:school_id/relationship',
    {
      school_id: '@school_id'
    }

angular.module('kulebaoAdmin')
.factory('relationshipService', ['$resource', relationshipService])