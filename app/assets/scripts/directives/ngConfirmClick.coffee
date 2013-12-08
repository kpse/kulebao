'use strict'

ngConfirmClick = () ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.bind "click", ->
      message = attrs.ngConfirmMsg
      if message and confirm(message)
        scope.$apply attrs.ngConfirmClick


angular.module(window.kulebaoApp).directive('ngConfirmClick', ngConfirmClick)