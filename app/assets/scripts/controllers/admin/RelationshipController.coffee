'use strict'

angular.module('kulebaoAdmin')
.controller 'RelationshipCtrl',
    ['$scope', '$rootScope', '$stateParams', '$location', 'schoolService', 'classService', 'parentService', 'relationshipService', '$modal', 'childService'
      (scope, rootScope, stateParams, location, School, Class, Parent, Relationship, modal, Child) ->
        rootScope.tabName = 'relationship'
        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: stateParams.kindergarten}).query()

        scope.relationships = Relationship.bind(school_id: stateParams.kindergarten).query()

        scope.parents = Parent.bind(school_id: stateParams.kindergarten).query()
        scope.children = Child.bind(school_id: stateParams.kindergarten).query()
        scope.relationship = scope.relationships[0]

        scope.newParent = ->
          scope.parent = new Parent
            school_id: parseInt(scope.kindergarten.school_id)
            birthday: '1980-1-1'
            gender: 1
            portrait: '/assets/images/portrait_placeholder.png'
            name: '马大帅'
            kindergarten: scope.kindergarten.school_info

          scope.currentModal = modal scope: scope, contentTemplate: 'templates/admin/add_parent_adult.html'

        scope.nextPage = ->
          scope.currentModal = modal scope: scope, contentTemplate: 'templates/admin/add_parent_child.html'

        scope.newChild = ->
          scope.currentModal = modal scope: scope, contentTemplate: 'templates/admin/add_parent_child.html'

        scope.newRelationship = ->
          scope.currentModal = modal scope: scope, contentTemplate: 'templates/admin/add_connection.html'

    ]

angular.module('kulebaoAdmin')
.controller 'addRelationshipCtrl',
    ['$scope', '$rootScope', '$stateParams', '$location', 'schoolService', 'classService', 'parentService', 'relationshipService', '$modal', 'childService', 'cardService',
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

        scope.isDuplicated = (card) ->
          return false if card is undefined || card.length < 10
          undefined isnt _.find scope.allCards, (c) ->
            c.card_id == card

    ]

