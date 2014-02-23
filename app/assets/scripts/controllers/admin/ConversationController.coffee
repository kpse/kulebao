'use strict'

angular.module('kulebaoAdmin')
.controller 'ConversationsListCtrl',
    [ '$scope', '$rootScope', '$stateParams',
      'schoolService', 'classService', '$location'
      (scope, rootScope, stateParams, School, Class, location) ->
        rootScope.tabName = 'conversation'

        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: scope.kindergarten.school_id}).query ->
            location.path(location.path() + '/class/' + scope.kindergarten.classes[0].class_id + '/list') if (location.path().indexOf('/class/') < 0)

        scope.navigateTo = (c) ->
          location.path(location.path().replace(/\/class\/.+$/, '') + '/class/' + c.class_id + '/list')

    ]

angular.module('kulebaoAdmin')
.controller 'ConversationsInClassCtrl',
    [ '$scope', '$rootScope', '$stateParams',
      '$location', 'schoolService', 'classService', 'parentService',
      (scope, rootScope, stateParams, location, School, Class, Parent) ->
        rootScope.tabName = 'conversation'

        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: scope.kindergarten.school_id}).query()
          scope.parents = Parent.bind(school_id: stateParams.kindergarten, class_id: stateParams.class_id).query ->
            _.forEach scope.parents, (p) ->
              p.lastMessage =
                content: '老师再见', timestamp: new Date().getTime()

        scope.goDetail = (parent) ->
          if (location.path().indexOf('/list') > 0 )
            location.path location.path().replace(/\/list$/, '/parent/' + parent.phone)
          else
            location.path location.path().replace(/\/parent\/\d+$/, '') + '/parent/' + parent.phone


    ]

angular.module('kulebaoAdmin')
.controller 'ConversationCtrl',
    [ '$scope', '$rootScope', '$stateParams',
      '$location', 'schoolService', '$http', 'classService', 'conversationService', 'parentService'
      (scope, rootScope, stateParams, location, School, $http, Class, Message, Parent) ->
        rootScope.tabName = 'conversation'

        scope.parent = Parent.bind(school_id: stateParams.kindergarten, parentId: stateParams.phone).get()
        scope.conversations = Message.bind(school_id: stateParams.kindergarten, phone: stateParams.phone, sort: 'desc').query()
        scope.newInput = 'please add comments'

        scope.send = (msg) ->
          return if msg is undefined || msg is ''
          m = new Message
            school_id: stateParams.kindergarten
            phone: stateParams.phone
            content: msg
            image: ''
            timestamp: 0
            sender: '老师'
          m.$save ->
            scope.newInput = ''
            scope.conversations = Message.bind(school_id: stateParams.kindergarten, phone: stateParams.phone, sort: 'desc').query()
    ]