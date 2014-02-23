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
      '$location', 'schoolService', 'classService', 'relationshipService', 'conversationService'
      (scope, rootScope, stateParams, location, School, Class, Relationship, Chat) ->
        rootScope.tabName = 'conversation'
        scope.current_class = stateParams.class_id
        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: scope.kindergarten.school_id}).query()
          scope.relationships = Relationship.bind(school_id: stateParams.kindergarten, class_id: stateParams.class_id).query ->
            _.forEach scope.relationships, (r) ->
              r.parent.messages = Chat.bind(school_id: stateParams.kindergarten, phone: r.parent.phone, most: 1, sort: 'desc').query ->
                r.parent.lastMessage = r.parent.messages[0]


        scope.goDetail = (card) ->
          if (location.path().indexOf('/list') > 0 )
            location.path location.path().replace(/\/list$/, '/card/' + card)
          else
            location.path location.path().replace(/\/card\/\d+$/, '') + '/card/' + card


    ]

angular.module('kulebaoAdmin')
.controller 'ConversationCtrl',
    [ '$scope', '$rootScope', '$stateParams',
      '$location', 'schoolService', '$http', 'classService', 'conversationService', 'relationshipService'
      (scope, rootScope, stateParams, location, School, $http, Class, Message, Relationship) ->
        rootScope.tabName = 'conversation'

        scope.relationship = Relationship.bind(school_id: stateParams.kindergarten, card: stateParams.card).get ->
          scope.conversations = Message.bind(school_id: stateParams.kindergarten, phone: scope.relationship.parent.phone, sort: 'desc').query()
        scope.newInput = ''

        scope.send = (msg) ->
          return if msg is undefined || msg is ''
          m = new Message
            school_id: stateParams.kindergarten
            phone: scope.relationship.parent.phone
            content: msg
            image: ''
            timestamp: 0
            sender: '老师'
          m.$save ->
            scope.newInput = ''
            scope.conversations = Message.bind(school_id: stateParams.kindergarten, phone: scope.relationship.parent.phone, sort: 'desc').query()
    ]