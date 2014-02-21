'use strict'

angular.module('kulebaoAdmin')
.controller 'ConversationsListCtrl',
    [ '$scope', '$rootScope', '$stateParams',
      'schoolService', 'classService', '$location'
      (scope, rootScope, stateParams, School, Class, location) ->
        rootScope.tabName = 'conversation'

        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: scope.kindergarten.school_id}).query ->
            location.path(location.path() + '/class/' + scope.kindergarten.classes[0].class_id) if (location.path().indexOf('/class/') < 0)

        scope.navigateTo = (c) ->
          location.path(location.path().replace(/\/class\/.+$/, '') + '/class/' + c.class_id)

    ]

angular.module('kulebaoAdmin')
.controller 'ConversationsInClassCtrl',
    [ '$scope', '$rootScope', '$stateParams',
      '$location', 'schoolService', 'classService', 'parentService',
      (scope, rootScope, stateParams, location, School, Class, Parent) ->
        rootScope.tabName = 'conversation'

        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: scope.kindergarten.school_id}).query()
          scope.parents = Parent.bind(school_id: stateParams.kindergarten, class_id: stateParams.class_id).query()

        scope.goDetail = (parent) ->
            location.path location.path().replace(/\/parent\/\d+$/, '') + '/parent/' + parent.phone


    ]

angular.module('kulebaoAdmin')
.controller 'ConversationCtrl',
    [ '$scope', '$rootScope', '$stateParams',
      '$location', 'schoolService', '$http', 'scheduleService', '$timeout', 'classService',
      (scope, rootScope, stateParams, location, School, $http, Schedule, $timeout, Class) ->
        rootScope.tabName = 'conversation'

        scope.conversations = [
          {phone: '123123123', content: '内容1', timestamp: 1231231231231 },
          {phone: '123123123', content: '内容2', timestamp: 1231232231231 },
          {phone: '123123123', content: '内容3', timestamp: 1231233231231 }
        ]

    ]