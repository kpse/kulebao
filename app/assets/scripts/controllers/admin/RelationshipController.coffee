'use strict'

angular.module('kulebaoAdmin')
.controller 'RelationshipCtrl',
    ['$scope', '$rootScope', '$stateParams', '$location', 'schoolService', 'classService', 'parentService',
     'relationshipService', '$modal', 'childService', '$http'
      (scope, rootScope, stateParams, location, School, Class, Parent, Relationship, modal, Child, $http) ->
        rootScope.tabName = 'relationship'
        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: stateParams.kindergarten}).query()

        scope.relationships = Relationship.bind(school_id: stateParams.kindergarten).query()

        scope.parents = Parent.bind(school_id: stateParams.kindergarten).query()
        scope.children = Child.bind(school_id: stateParams.kindergarten).query()
        scope.relationship = scope.relationships[0]

        scope.$on 'newRelationship', ->
          scope.relationships = Relationship.bind(school_id: stateParams.kindergarten).query()

        scope.newParent = ->
          scope.currentModal = modal scope: scope, contentTemplate: 'templates/admin/add_adult.html'

        scope.newChild = ->
          scope.currentModal = modal scope: scope, contentTemplate: 'templates/admin/add_child.html'

        scope.newRelationship = ->
          scope.currentModal = modal scope: scope, contentTemplate: 'templates/admin/add_connection.html'

        generateCheckingInfo = (card, name, type) ->
          school_id: parseInt(stateParams.kindergarten)
          card_no: card
          card_type: 2
          notice_type: type
          record_url: 'http://suoqin-test.u.qiniudn.com/FoUJaV4r5L0bM0414mGWEIuCLEdL'
          parent: name
          timestamp: new Date().getTime()

        scope.sendMessage = (relationship, type) ->
          check = generateCheckingInfo(relationship.card, relationship.parent.name, type)
          $http({method: 'POST', url: '/kindergarten/' + stateParams.kindergarten + '/check', data: check}).success (data) ->
            alert 'error_code:' + data.error_code

    ]

angular.module('kulebaoAdmin')
.controller 'addRelationshipCtrl',
    ['$scope', '$rootScope', '$stateParams', '$location', 'schoolService', 'classService', 'parentService',
     'relationshipService', '$modal', 'childService', 'cardService',
      (scope, rootScope, stateParams, location, School, Class, Parent, Relationship, modal, Child, Card) ->
        rootScope.tabName = 'relationship'
        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: stateParams.kindergarten}).query()

        scope.relationships = Relationship.bind(school_id: stateParams.kindergarten).query()

        scope.parents = Parent.bind(school_id: stateParams.kindergarten).query()
        scope.children = Child.bind(school_id: stateParams.kindergarten).query()
        scope.relationship = new Relationship(school_id: stateParams.kindergarten, relationship: '妈妈')

        scope.allCards = Card.bind(school_id: stateParams.kindergarten).query()

        scope.createRelationship = (relationship) ->
          relationship.$save ->
            scope.$hide()
            scope.$emit 'newRelationship'

        scope.isDuplicated = (card) ->
          return false if card is undefined || card.length < 10
          undefined isnt _.find scope.allCards, (c) ->
            c.card_id == card

    ]

angular.module('kulebaoAdmin')
.controller 'addParentCtrl',
    ['$scope', '$rootScope', '$stateParams', '$location', 'schoolService', 'classService', 'parentService',
     'relationshipService', '$modal', 'childService', '$http', 'uploadService',
      (scope, rootScope, stateParams, location, School, Class, Parent, Relationship, modal, Child, $http, uploadService) ->
        rootScope.tabName = 'relationship'
        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: stateParams.kindergarten}).query()

        scope.parent = new Parent
          school_id: scope.kindergarten.school_id
          birthday: '1980-1-1'
          gender: 1
          portrait: '/assets/images/portrait_placeholder.png'
          name: '马大帅'
          kindergarten: scope.kindergarten.school_info

        scope.relationships = Relationship.bind(school_id: stateParams.kindergarten).query()

        scope.parents = Parent.bind(school_id: stateParams.kindergarten).query()
        scope.children = Child.bind(school_id: stateParams.kindergarten).query()
        scope.relationship = new Relationship(school_id: stateParams.kindergarten, relationship: '妈妈')

        scope.create = (parent) ->
          parent.$save ->
            scope.$hide()

        scope.isDuplicated = (phone) ->
          return false if phone is undefined
          undefined isnt _.find scope.parents, (p) ->
            p.phone == phone

        upload = (file, callback)->
          return callback(undefined) if file is undefined
          $http.get('/ws/fileToken?bucket=suoqin-test').success (data)->
            uploadService.send file, data.token, (remoteFile) ->
              callback(remoteFile.url)

        scope.uploadPic = (person, pic) ->
          upload pic, (url) ->
            scope.$apply ->
              person.portrait = url if url isnt undefined
    ]

angular.module('kulebaoAdmin')
.controller 'addChildCtrl',
    ['$scope', '$rootScope', '$stateParams', '$location', 'schoolService', 'classService', 'parentService',
     'relationshipService', '$modal', 'childService', '$http', 'uploadService',
      (scope, rootScope, stateParams, location, School, Class, Parent, Relationship, modal, Child, $http, uploadService) ->
        rootScope.tabName = 'relationship'
        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: stateParams.kindergarten}).query ->
            scope.child = new Child
              name: '宝宝名字'
              nick: '宝宝小名'
              birthday: '2009-1-1'
              gender: 1
              portrait: '/assets/images/portrait_placeholder.png'
              class_id: scope.kindergarten.classes[0].class_id
              school_id: scope.kindergarten.school_info.school_id

        scope.relationships = Relationship.bind(school_id: stateParams.kindergarten).query()

        scope.parents = Parent.bind(school_id: stateParams.kindergarten).query()
        scope.children = Child.bind(school_id: stateParams.kindergarten).query()
        scope.relationship = new Relationship(school_id: stateParams.kindergarten, relationship: '妈妈')

        scope.create = (child) ->
          child.$save ->
            scope.$hide()

        upload = (file, callback)->
          return callback(undefined) if file is undefined
          $http.get('/ws/fileToken?bucket=suoqin-test').success (data)->
            uploadService.send file, data.token, (remoteFile) ->
              callback(remoteFile.url)

        scope.uploadPic = (person, pic) ->
          upload pic, (url) ->
            scope.$apply ->
              person.portrait = url if url isnt undefined
    ]

