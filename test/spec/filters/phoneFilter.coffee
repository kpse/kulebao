'use strict'

describe 'Filter: phoneFilter', () ->

  # load the filter's module
  beforeEach module 'kulebaoAdmin'

  # initialize a new instance of the filter before each test
  phoneFilter = {}
  beforeEach inject ($filter) ->
    phoneFilter = $filter 'phone'

  it 'should format the phone number', () ->
    text = '12345678901'
    expect(phoneFilter text).toBe ('123-4567-8901')
