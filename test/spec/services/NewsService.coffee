'use strict'

describe 'Service: newsService', () ->

  # load the service's module
  beforeEach module 'kulebaoApp'

  # instantiate service
  newsService = {}
  beforeEach inject (_newsService_) ->
    newsService = _newsService_

  it 'should do something', () ->
    expect(!!newsService).toBe true
