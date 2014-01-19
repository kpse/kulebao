class Controller
  constructor: (scope, rootScope, Feedback, Parent) ->
    rootScope.tabName = 'feedback'
    scope.loading = true
    scope.allFeedback = Feedback.query ->
      scope.loading = false



angular.module('kulebaoOp').controller 'OpFeedbackCtrl', ['$scope', '$rootScope', 'feedbackService', 'parentService', Controller]

