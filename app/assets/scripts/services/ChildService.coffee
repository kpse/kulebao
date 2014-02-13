'use strict'

childService = ($resource) ->
  $resource '/kindergarten/:school_id/child/:child_id',
    {
      school_id: '@school_id'
      child_id: '@child_id'
    }

angular.module('kulebaoAdmin')
.factory('childService', ['$resource', childService])
