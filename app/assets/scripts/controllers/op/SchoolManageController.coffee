class Controller
  constructor: (scope, rootScope, School, Clazz) ->
    scope.classes = []
    scope.kindergartens = School.query ->
      scope.current_kindergarten = scope.kindergartens[0]
      _.each scope.kindergartens, (kg) ->
        classInSchool = Clazz.bind(school_id: kg.school_id).query ->
          console.log(classInSchool)
          updatedClass = _.map classInSchool, (c) ->
            c.school = kg
            c
          scope.classes = scope.classes.concat updatedClass


    rootScope.tabName = 'school'



angular.module('kulebaoOp').controller 'OpSchoolCtrl', ['$scope', '$rootScope', 'schoolService', 'classService', Controller]

