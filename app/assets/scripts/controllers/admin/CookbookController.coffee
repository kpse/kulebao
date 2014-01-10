'use strict'

angular.module('kulebaoAdmin')
.controller 'CookbookCtrl', [ '$scope', '$rootScope', '$stateParams',
                           '$location', 'schoolService', '$http', 'cookbookService', '$timeout',
  (scope, rootScope, stateParams, location, School, $http, Cookbook, $timeout) ->
    rootScope.tabName = 'cookbook'
    scope.cookbook_changed = false
    scope.isEditing = false

    scope.kindergarten = School.get school_id: stateParams.kindergarten

    scope.cookbooks = Cookbook.bind(school_id: stateParams.kindergarten).query ->
      scope.cookbook = scope.cookbooks[0]
      scope.$watch 'cookbook', (oldv, newv) ->
          scope.cookbook_changed = true if newv isnt oldv
        , true

    scope.toggleEditing = (e) ->
      e.stopPropagation()
      scope.isEditing = !scope.isEditing
      console.log 'scope.cookbook changed: ' + scope.cookbook_changed
      if scope.cookbook_changed
        $timeout ->
            scope.cookbook.$save()
            scope.cookbook_changed = false
          , 0, true
]
