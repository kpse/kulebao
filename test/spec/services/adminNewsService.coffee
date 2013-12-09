'use strict'

describe 'Service: adminNewsService', () ->

  # load the service's module
  beforeEach module 'kulebaoAdmin'

  # instantiate service
  adminNewsService = {}
  beforeEach inject (_adminNewsService_) ->
    adminNewsService = _adminNewsService_

  it 'should do something', () ->
    expect(!!adminNewsService).toBe true
