'use strict'

ngBkFocus = () ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element[0].focus


angular.module('kulebaoApp').directive('ngBkFocus', ngBkFocus)