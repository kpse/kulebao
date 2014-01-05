'use strict'

childService = ($resource) ->
  $resource '/kindergarten/:school_id/child',
    {
      school_id: '@school_id'
    }

angular.module('kulebaoAdmin')
.factory('childService', ['$resource', childService])