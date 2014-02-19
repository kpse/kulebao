'use strict'

ngBkFocus = ($timeout) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    $timeout ->
        element[0].focus() if scope.$eval(attrs['ngBkFocus']) || attrs['ngBkFocus'] is ''
      , 500, false


angular.module('kulebaoApp').directive('ngBkFocus', ngBkFocus)