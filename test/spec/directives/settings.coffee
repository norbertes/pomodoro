'use strict'

describe 'Directive: settings', ->

  # load the directive's module
  beforeEach module 'pomodoroApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<settings></settings>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the settings directive'
