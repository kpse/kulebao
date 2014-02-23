class Config
  constructor: ($stateProvider, $urlRouterProvider) ->
    $stateProvider
    .state 'kindergarten',
        url: '/kindergarten/:kindergarten',
        templateUrl: 'templates/admin/kindergarten_manage.html',
        controller: 'KgManageCtrl'
    .state 'kindergarten.bulletin',
        url: '/bulletin',
        templateUrl: 'templates/admin/bulletin_manage.html',
        controller: 'BulletinManageCtrl'
    .state 'kindergarten.news',
        url: '/news/:news',
        templateUrl: 'templates/admin/news_edit.html',
        controller: 'NewsEditCtrl'
    .state 'kindergarten.parents',
        url: '/parents',
        templateUrl: 'templates/admin/parents.html',
        controller: 'ParentsCtrl'
    .state 'kindergarten.parents.class',
        url: '/class/:classId',
        templateUrl: 'templates/admin/classes.html',
        controller: 'ParentsInClassCtrl'
    .state 'kindergarten.parents.class.list',
        url: '/list',
        templateUrl: 'templates/admin/list_parents.html',
        controller: 'ParentsInClassCtrl'
    .state 'kindergarten.parents.class.edit_adult',
        url: '/edit_adult',
        templateUrl: 'templates/admin/add_parent_adult.html',
        controller: 'EditParentCtrl'
    .state 'kindergarten.parents.class.edit_child',
        url: '/edit_child',
        templateUrl: 'templates/admin/add_parent_child.html',
        controller: 'EditParentCtrl'
    .state 'kindergarten.swipingcard',
        url: '/swipingcard',
        templateUrl: 'templates/admin/swipingcard.html',
        controller: 'AccountCtrl'
    .state 'kindergarten.intro',
        url: '/intro',
        templateUrl: 'templates/admin/intro.html',
        controller: 'IntroCtrl'
    .state 'kindergarten.cookbook',
        url: '/cookbook',
        templateUrl: 'templates/admin/cookbook.html',
        controller: 'CookbookCtrl'
    .state 'kindergarten.schedule',
        url: '/schedule',
        templateUrl: 'templates/admin/schedule.html',
        controller: 'ScheduleCtrl'
    .state 'kindergarten.schedule.class',
        url: '/class/:class_id',
        templateUrl: 'templates/admin/class_schedule.html',
        controller: 'ClassScheduleCtrl'
    .state 'kindergarten.conversation',
        url: '/conversation',
        templateUrl: 'templates/admin/all_conversations.html',
        controller: 'ConversationsListCtrl'
    .state 'kindergarten.conversation.class',
        url: '/class/:class_id',
        templateUrl: 'templates/admin/classes.html',
        controller: 'ConversationsInClassCtrl'
    .state 'kindergarten.conversation.class.list',
        url: '/list',
        templateUrl: 'templates/admin/conversation_in_class.html',
        controller: 'ConversationsInClassCtrl'
    .state 'kindergarten.conversation.class.parent',
        url: '/parent/:phone',
        templateUrl: 'templates/admin/conversation.html',
        controller: 'ConversationCtrl'

    .state('kindergarten.wip',
        url: '/wip',
        template: '<div>Sorry, we are still in Building...</div><image class="img-responsive" src="assets/images/wip.gif"></image>',
        controller: 'WipCtrl'
      )

    $urlRouterProvider.otherwise ($injector, $location) ->
      path = $location.path()
      if path.indexOf("kindergarten", 0) < 0
      then $location.path '/kindergarten/93740362'
      else $location.path path.replace /(kindergarten\/[^\/]+)\/.+$/g, '$1/wip'


angular.module('kulebaoApp', ['ui.router', 'ngResource', 'ngRoute', 'angulartics', 'angulartics.google.analytics'])
angular.module('kulebaoAdmin', ['kulebaoApp', 'ui.router', 'ngResource', 'ngRoute', 'ui.bootstrap', 'ui.mask', '$strap.directives', 'angulartics', 'angulartics.google.analytics'])
.config ['$stateProvider', '$urlRouterProvider', Config]
