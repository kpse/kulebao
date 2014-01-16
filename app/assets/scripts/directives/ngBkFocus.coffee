'use strict'

ngBkFocus = () ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element[0].focus() if scope.$eval(attrs['ngBkFocus']) || attrs['ngBkFocus'] is ''


angular.module('kulebaoApp').directive('ngBkFocus', ngBkFocus)