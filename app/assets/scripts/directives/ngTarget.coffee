'use strict'

ngTarget =  ($parse, $timeout) ->
  NON_ASSIGNABLE_MODEL_EXPRESSION = "Non-assignable model expression: "
  restrict: "A"
  link: (scope, element, attr) ->
    buildGetterSetter = (name) ->
      me = {}
      me.get = $parse(name)
      me.set = me.get.assign
      throw Error(NON_ASSIGNABLE_MODEL_EXPRESSION + name)  unless me.set
      me


    # *********** focus ***********
    focusTriggerName = attr.ngTarget + "._focusTrigger"
    focusTrigger = buildGetterSetter(focusTriggerName)
    focus = buildGetterSetter(attr.ngTarget + ".focus")
    focusTrigger.set scope, 0
    focus.set scope, ->
      focusTrigger.set scope, 1


    # $watch the trigger variable for a transition
    scope.$watch focusTriggerName, (newValue, oldValue) ->
      if newValue > 0
        $timeout (-> # a timing workaround hack
          element[0].focus() # without jQuery, need [0]
          focusTrigger.set scope, 0
        ), 50


    # *********** blur ***********
    blurTriggerName = attr.ngTarget + "._blurTrigger"
    blurTrigger = buildGetterSetter(blurTriggerName)
    blur = buildGetterSetter(attr.ngTarget + ".blur")
    blurTrigger.set scope, 0
    blur.set scope, ->
      blurTrigger.set scope, 1


    # $watch the trigger variable for a transition
    scope.$watch blurTriggerName, (newValue, oldValue) ->
      if newValue > 0
        $timeout (-> # a timing workaround hack
          element[0].blur() # without jQuery, need [0]
          blurTrigger.set scope, 0
        ), 50


    # *********** select ***********
    selectTriggerName = attr.ngTarget + "._selectTrigger"
    selectTrigger = buildGetterSetter(selectTriggerName)
    select = buildGetterSetter(attr.ngTarget + ".select")
    selectTrigger.set scope, 0
    select.set scope, ->
      selectTrigger.set scope, 1


    # $watch the trigger variable for a transition
    scope.$watch selectTriggerName, (newValue, oldValue) ->
      if newValue > 0
        $timeout (-> # a timing workaround hack
          element[0].select() # without jQuery, need [0]
          selectTrigger.set scope, 0
        ), 50


angular.module('kulebaoApp').directive('ngTarget', ngTarget)