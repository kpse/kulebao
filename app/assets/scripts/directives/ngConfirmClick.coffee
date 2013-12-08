'use strict'

ngConfirmClick = () ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.bind "click", ->
      message = attrs.ngConfirmationMessage
      scope.$apply attrs.ngConfirmClick if message and confirm(message)


angular.module(window.kulebaoApp).directive('ngConfirmClick', ngConfirmClick)