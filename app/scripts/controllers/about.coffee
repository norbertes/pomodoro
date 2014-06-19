'use strict'

###*
 # @ngdoc function
 # @name pomodoroApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the pomodoroApp
###
angular.module('pomodoroApp')
  .controller 'AboutCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
