'use strict'

angular.module('kulebaoApp')
.filter 'phone', () ->
    (tel) ->
      return "" unless tel
      value = tel.toString().trim().replace(/^\+/, "")
      return tel if value.match(/[^0-9]/)
      part1 = value.slice(0, 3)
      part2 = value.slice(3, 7)
      part3 = value.slice(7)
      (part1 + '-' + part2 + '-' + part3).trim()

