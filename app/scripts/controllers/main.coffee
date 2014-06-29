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
	$scope.pomodoroTime = 60*25	# Czas trwania pomodoro
	$scope.shortBreak = 60*5	# Czas trwania krótkiej przerwy
	$scope.longBreak = 60*25	# Czas trwania długiej przerwy
	$scope.counter 	= $scope.pomodoroTime	# Czas na liczniku (init = czas pomodoro)
	$scope.isActive = false		# Czy zegrar chodzi
	$scope.timeTable = []		# Tabela z datami zakończeń pomodoro
	mytimeout = false			# Zmienna do countera
	work = true 				# work = true, break = false

	# Zatrzymanie odliczania
	stop = () ->
		$timeout.cancel(mytimeout);

	# Ustawienie kolejnego pomodoro
	setAction = () ->
		# stop()
		$scope.toggleCounter()
		work = !work
		if work
			$scope.counter = $scope.pomodoroTime
		else
			$scope.timeTable.push Date.now()
			if $scope.timeTable.length % 4 is 0
				$scope.counter = $scope.longBreak
			else
				$scope.counter = $scope.shortBreak

	# Odliczanie
	countDown = () ->
		$scope.counter--
		if $scope.counter > 0
			mytimeout = $timeout countDown,1000
		else
			setAction()

	$scope.formatCounter = (val) ->
		mins = Math.floor val/60
		secs = val - mins * 60
		if secs < 10 then secs = '0' + secs
		mins + ':' + secs

	$scope.toggleCounter = () ->
		if !$scope.isActive
			countDown()
		else
			stop()
		$scope.isActive = !$scope.isActive
