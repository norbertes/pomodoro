'use strict'

###*
 # @ngdoc function
 # @name pomodoroApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the pomodoroApp
###
angular.module('pomodoroApp')
  .controller 'MainCtrl', ($scope, $timeout) ->
	$scope.counter = 60*25
	isCounterRunning = false
	mytimeout = false

	stop = () ->
		$timeout.cancel(mytimeout);

	countDown = () ->
		$scope.counter--
		mytimeout = $timeout countDown,1000

	$scope.formatCounter = (val) ->
		mins = Math.floor val/60
		secs = val - mins * 60
		if secs < 10 then secs = '0' + secs
		mins + ':' + secs

	$scope.toggleCounter = () ->
        if !isCounterRunning
        	countDown()
        else
        	stop()
        isCounterRunning = if isCounterRunning then false else true