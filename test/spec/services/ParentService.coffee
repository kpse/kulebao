'use strict'

describe 'Service: ParentService', () ->

  # load the service's module
  beforeEach module 'kulebaoAdmin'

  # instantiate service
  ParentService = {}
  beforeEach inject (_parentService_) ->
    ParentService = _parentService_

  it 'should do something', () ->
    expect(!!ParentService).toBe true
