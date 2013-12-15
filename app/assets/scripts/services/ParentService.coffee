'use strict'

parentService = ($resource) ->
  $resource '/kindergarten/:kg/parent/:parentId',
    {
      kg: '@kg'
      parentId: '@id'
    }

angular.module('kulebaoAdmin')
.factory('parentService', ['$resource', parentService])