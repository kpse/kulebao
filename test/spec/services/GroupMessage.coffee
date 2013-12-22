'use strict'

describe 'Service: GroupMessage', () ->

  # load the service's module
  beforeEach module 'kulebaoAdmin'

  # instantiate service
  GroupMessage = {}
  beforeEach inject (_GroupMessage_) ->
    GroupMessage = _GroupMessage_

  it 'should do something', () ->
    expect(!!GroupMessage).toBe true
