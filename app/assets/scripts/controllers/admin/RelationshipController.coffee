'use strict'

angular.module('kulebaoAdmin')
.controller 'RelationshipCtrl',
    ['$scope', '$rootScope', '$stateParams', '$location', 'schoolService', 'classService', 'parentService', 'relationshipService', '$modal'
      (scope, rootScope, stateParams, location, School, Class, Parent, Relationship, modal) ->
        rootScope.tabName = 'relationship'
        scope.kindergarten = School.get school_id: stateParams.kindergarten, ->
          scope.kindergarten.classes = Class.bind({school_id: stateParams.kindergarten}).query()

        scope.relationships = Relationship.bind(school_id: stateParams.kindergarten).query()

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

    ]

