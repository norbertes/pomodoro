'use strict'

###*
 # @ngdoc directive
 # @name pomodoroApp.directive:counter
 # @description
 # # counter
###
angular.module('pomodoroApp')
	.directive 'counter', ->
		templateUrl: 'views/main.html'
		restrict: 'E'
		controllerAs: 'CounterCtrl'
		controller: ($scope, $timeout) ->
			$scope.pomodoroTime = 60*25	# Czas trwania pomodoro
			$scope.shortBreak = 60*5	# Czas trwania krótkiej przerwy
			$scope.longBreak = 60*25	# Czas trwania długiej przerwy
			$scope.counter 	= $scope.pomodoroTime	# Czas na liczniku (init = czas pomodoro)
			$scope.isActive = true		# Czy zegrar chodzi
			$scope.timeTable = []		# Tabela z datami zakończeń pomodoro
			mytimeout = false			# Zmienna do countera
			work = true 				# work = true, break = false

			# btn-warning - na pauzie
			# btn-primary - na normalnym czasie
			# btn-success - przed przerwa
			setButton = (val) ->
				if val is 1
					btnClass = 'btn-primary'
				else if val is 2
					btnClass = 'btn-success'
				else if val is 3
					btnClass = 'btn-warning'
				$('.js-startbutton').removeClass('btn-primary btn-success btn-warning').addClass btnClass

			# Zatrzymanie odliczania
			stop = () ->
				$timeout.cancel mytimeout

			# Ustawienie kolejnego pomodoro
			setAction = () ->
				# stop()
				$scope.toggleCounter()
				playSound()
				work = !work
				if work
					setButton 2
					$scope.counter = $scope.pomodoroTime
				else
					$scope.timeTable.push Date.now()
					setButton 1
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


			playSound = ->
				# if !$scope.mute
				snd = new Audio '../sounds/success.wav'
				snd.play()

			$scope.formatCounter = (val) ->
				mins = Math.floor val/60
				secs = val - mins * 60
				if secs < 10 then secs = '0' + secs
				mins + ':' + secs

			$scope.toggleCounter = () ->
				if $scope.isActive
					$scope.$emit 'counterStart'
					setButton 2
					countDown()
				else
					$scope.$emit 'counterStop'
					setButton 3
					stop()
				$scope.isActive = !$scope.isActive

			setButton 2

