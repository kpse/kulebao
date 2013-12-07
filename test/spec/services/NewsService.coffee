'use strict'

describe 'Service: Newsservice', () ->

  # load the service's module
  beforeEach module 'kulebaoApp'

  # instantiate service
  Newsservice = {}
  beforeEach inject (_Newsservice_) ->
    Newsservice = _Newsservice_

  it 'should do something', () ->
    expect(!!Newsservice).toBe true
