#Jasmine test, see http://pivotal.github.com/jasmine/for more information
describe 'app', ->
  beforeEach module 'app'

  describe 'KindergartenCtrl', ->
    it 'should be working', ->
      expect(1 + 1).toBe 2