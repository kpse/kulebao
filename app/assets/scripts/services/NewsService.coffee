'use strict'

class Service
  constructor: () ->

  get: ->
    [
      {id: 1, title: '通知1', content: '缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知', read: true, issueDate: new Date},
      {id: 2, title: '通知2', content: '缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知', read: false, issueDate: new Date},
      {id: 3, title: '通知3', content: '缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知', read: false, issueDate: new Date}
    ]

  getNews: (id) ->
    @get().filter (item) ->
      item.id == parseInt(id, 10)

angular.module('app').service 'newsService', Service