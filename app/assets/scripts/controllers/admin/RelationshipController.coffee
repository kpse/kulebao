'use strict'

angular.module('kulebaoAdmin')
.controller 'RelationshipCtrl',
    ['$scope', '$rootScope', '$stateParams', '$location', 'schoolService', 'classService', 'parentService', 'relationshipService'
      ($scope, $rootScope, $stateParams, $location, School, Class, Parent, Relationship) ->
        $rootScope.tabName = 'relationship'
        $scope.kindergarten = School.get school_id: $stateParams.kindergarten, ->
          $scope.kindergarten.classes = Class.bind({school_id: $stateParams.kindergarten}).query()

        $scope.relationships = Relationship.bind(school_id: $stateParams.kindergarten).query()

    ]

