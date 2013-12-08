'use strict'

describe 'Service: Adminnewsservice', () ->

  # load the service's module
  beforeEach module 'kulebaoApp'

  # instantiate service
  Adminnewsservice = {}
  beforeEach inject (_Adminnewsservice_) ->
    Adminnewsservice = _Adminnewsservice_

  it 'should do something', () ->
    expect(!!Adminnewsservice).toBe true
