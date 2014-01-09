'use strict'

classService = ($resource) ->
  $resource '/kindergarten/:school_id/class/:class_id',
    {
      school_id: '@school_id'
      class_id: '@class_id'
    }

angular.module('kulebaoAdmin')
.factory('classService', ['$resource', classService])