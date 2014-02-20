'use strict'

parentService = ($resource) ->
  $resource '/kindergarten/:school_id/parent/:phone',
    {
      school_id: '@school_id'
      phone: '@phone'
    }

angular.module('kulebaoAdmin')
.factory('parentService', ['$resource', parentService])