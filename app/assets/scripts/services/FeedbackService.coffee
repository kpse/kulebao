'use strict'


feedbackService= ($resource) ->
  $resource '/feedback'

angular.module('kulebaoOp')
.factory('feedbackService', ['$resource', feedbackService])
