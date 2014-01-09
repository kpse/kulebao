'use strict'

classService = ($resource) ->
  $resource '/kindergarten/:school_id/class/:class_id',
    {
      school_id: '@school_id'
      class_id: '@class_id'
    }

angular.module('kulebaoAdmin')
.factory('classService', ['$resource', classService])

schoolService = ($resource) ->
  $resource '/kindergarten/:school_id',
    {
      school_id: '@school_id'
    }, {
      'get':    {method:'GET', cache: true}
    }


angular.module('kulebaoAdmin')
.factory('schoolService', ['$resource', schoolService])