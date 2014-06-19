'use strict'

###*
 # @ngdoc function
 # @name pomodoroApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the pomodoroApp
###
angular.module('pomodoroApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
