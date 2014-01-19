class Controller
  constructor: (scope, rootScope, School, Clazz) ->

    scope.classes = []
    scope.kindergartens = School.query ->
      scope.current_kindergarten = scope.kindergartens[0]
      _.each scope.kindergartens, (kg) ->
        kg.manager =
          name: '空条承太郎'
        classInSchool = Clazz.bind(school_id: kg.school_id).query ->
          updatedClass = _.map classInSchool, (c) ->
            c.school = kg
            c
          scope.classes = scope.classes.concat updatedClass


    rootScope.tabName = 'school'

    scope.edit = (clazz) ->
      alert('编辑 "' + clazz.name + '"!')

    scope.delete = ->
      alert('暂未实现')

    scope.addSchool = ->
      newSchool = new School(school_id: '93999999')
      newClass = new Clazz(school_id: newSchool.school_id)
      newClass.school = newSchool
      newSchool.$save ->
        newClass.$save ->
          scope.$apply ->
            scope.classes = scope.classes.concat newClass



    scope.addClass = ->
      alert('暂未实现')


angular.module('kulebaoOp').controller 'OpSchoolCtrl', ['$scope', '$rootScope', 'schoolService', 'classService', Controller]

