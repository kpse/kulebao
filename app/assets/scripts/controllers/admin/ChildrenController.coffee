'use strict'

angular.module('kulebaoAdmin')
.controller 'ConnectToChildCtrl',
    ['$scope', '$rootScope', '$stateParams', '$location', 'schoolService', 'classService', 'parentService', 'childService',
      (scope, rootScope, stateParams, location, School, Class, Parent, Children) ->
        rootScope.tabName = 'parents'
        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.class = stateParams.classId

        scope.backToList = () ->
          location.path(location.path().replace(/\/[^\/]+$/, '/list'))

        if rootScope.parent isnt undefined
          scope.parent = rootScope.parent
          scope.children = Children.bind(school_id: stateParams.kindergarten).query()
        else
          scope.backToList()

        scope.connect = (parent, child) ->
          parent.child = Children.bind(school_id: stateParams.kindergarten, child_id: child.id).get ->
            location.path(location.path().replace(/\/[^\/]+$/, '/edit_child'))
    ]
