'use strict'

describe 'Directive: counter', ->

  # load the directive's module
  beforeEach module 'pomodoroApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<counter></counter>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the counter directive'
