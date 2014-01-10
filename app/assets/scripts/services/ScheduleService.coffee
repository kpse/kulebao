'use strict'

scheduleService = ($resource) ->
  $resource '/kindergarten/:school_id/class/:class_id/schedule/:schedule_id',
    {
      school_id: '@school_id'
      class_id: '@class_id'
      schedule_id: '@schedule_id'
    }

angular.module('kulebaoAdmin')
.factory('scheduleService', ['$resource', scheduleService])