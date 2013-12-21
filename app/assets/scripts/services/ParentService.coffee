'use strict'

parentService = ($resource) ->
  $resource '/kindergarten/:school_id/parent/:parentId',
    {
      school_id: '@school_id'
      parentId: '@id'
    }

angular.module('kulebaoAdmin')
.factory('parentService', ['$resource', parentService])