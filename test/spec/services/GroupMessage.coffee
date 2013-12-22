'use strict'

describe 'Service: Groupmessage', () ->

  # load the service's module
  beforeEach module 'kulebaoApp'

  # instantiate service
  Groupmessage = {}
  beforeEach inject (_Groupmessage_) ->
    Groupmessage = _Groupmessage_

  it 'should do something', () ->
    expect(!!Groupmessage).toBe true
