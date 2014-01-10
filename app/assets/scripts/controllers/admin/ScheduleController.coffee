'use strict'

angular.module('kulebaoAdmin')
.controller 'ScheduleCtrl', [ '$scope', '$rootScope', '$stateParams',
                           '$location', 'schoolService', '$http', 'scheduleService', '$timeout', 'classService',
  (scope, rootScope, stateParams, location, School, $http, Schedule, $timeout, Class) ->
    rootScope.tabName = 'schedule'

    scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
      scope.kindergarten.classes = Class.bind({school_id: scope.kindergarten.school_id}).query ->
        scope.current_class = scope.kindergarten.classes[0]

        scope.$watch 'current_class', (oldv, newv) ->
            location.path(location.path().replace(/\d+$/, scope.current_class.class_id)) if newv isnt oldv
          , true
        location.path(location.path() + '/class/' + scope.current_class.class_id) if location.path().indexOf('/class/') < 0
]

angular.module('kulebaoAdmin')
.controller 'ClassScheduleCtrl', [ '$scope', '$rootScope', '$stateParams',
                              '$location', 'schoolService', '$http', 'scheduleService', '$timeout', 'classService',
    (scope, rootScope, stateParams, location, School, $http, Schedule, $timeout, Class) ->

      rootScope.tabName = 'schedule'

      scope.schedule_changed = false
      scope.isEditing = false

      scope.schedules = Schedule.bind(school_id: stateParams.kindergarten, class_id: stateParams.class_id).query ->
        scope.schedule = scope.schedules[0]
        scope.$watch 'schedule', (oldv, newv) ->
            scope.schedule_changed = true if (newv isnt oldv)
          , true

      scope.toggleEditing = (e) ->
        e.stopPropagation()
        scope.isEditing = !scope.isEditing
        console.log 'scope.schedule changed: ' + scope.schedule_changed
        if scope.schedule_changed
          $timeout ->
            scope.schedule.$save()
            scope.schedule_changed = false
          , 0, true
  ]