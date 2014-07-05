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
		controller: ($scope, $timeout, $window) ->
			$scope.pomodoroTime = 2#60*25	# Pomodoro work time
			$scope.shortBreak = 2#60*5	# Short break time
			$scope.longBreak = 2#60*25	# Long break time
			$scope.counter 	= $scope.pomodoroTime	# Counter value (init = pomodoros work time)
			$scope.isActive = true		# If counter running?
			$scope.timeTable = []		# Table for times of finish every block
			$scope.volume = 0.75		# Notifications volume
			mytimeout = false			# Helper for counter
			work = true 				# work = true, break = false

			# Change backgroun color
			setBackground = (val) ->
				if val is 1
					bgColor = '#428bca'
				else if val is 2
					bgColor = '#449d44'
				else if val is 3
					bgColor = '#ec971f'

				$('body').css 'background',bgColor

			# Show notification
			showNotification = (val) ->
				if val is 1
					if isShortBreak()
						pic = 'images/coffee.png'
					else
						pic = 'images/dinner.png'
					notify = new Notify 'Pomodoro',
						body: 'Czas na przerwę!'
						icon: pic
						timeout: 10
					.show()
				else if val is 2
					notify = new Notify 'Pomodoro',
						body: 'Koniec przerwy!'
						icon: 'images/pomodoro.png'
						timeout: 10
					.show()
				else if val is 3
					notify = new Notify 'Pomodoro',
						body: 'Alert!'
						icon: 'images/pomodoro.png'
						timeout: 10
					.show()

			# Permisin for system notifiactions
			requestNotificationPermission = () ->
				if Notify.needsPermission() and Notify.isSupported()
					Notify.requestPermission()

			# Stop counter
			stop = () ->
				$timeout.cancel mytimeout

			pushTimeTable = (val) ->
				console.log 'pushTimeTable'
				if val is 'work'
					$scope.timeTable.push {date: Date.now(), type: 'work'}
					$scope.$emit 'addWork'
				else
					$scope.timeTable.push {date: Date.now(), type: 'break'}
					$scope.$emit 'addBreak'

			# When counter comes to 0, set new action
			setAction = () ->
				# stop()
				$scope.toggleCounter()
				playSound()
				work = !work
				if work
					# console.log $scope.timeTable.length
					# if $scope.timeTable.length % 4 is 0 then brk = 'longbreak' else brk = 'break'
					pushTimeTable 'break'
					setBackground 2
					showNotification 2
					$scope.counter = $scope.pomodoroTime
				else
					pushTimeTable 'work'
					setBackground 1
					if isShortBreak()
						$scope.counter = $scope.shortBreak
						showNotification 1
					else
						$scope.counter = $scope.longBreak
						showNotification 1

			# Counter
			countDown = () ->
				$scope.counter--
				if $scope.counter > 0
					mytimeout = $timeout countDown,1000
				else
					setAction()

			# Play sound
			playSound = ->
				unless $scope.volume
					snd = new Audio '../sounds/success.wav'
					snd.volume = $scope.volume
					snd.play()

			#
			isShortBreak = ->
				console.log 'isShortBreak'
				cnt = $scope.timeTable.filter (val) -> val.type is 'work'
				if cnt.length % 4 isnt 0
					return true
				else
					return false

			# Keep full window size
			$scope.initializeWindowSize = ->
				$scope.windowHeight = $window.innerHeight
				$scope.windowWidth  = $window.innerWidth
				$scope.paddingTop = $window.innerHeight * 0.2

			# Format timestamp to nice date format
			$scope.formatCounter = (val) ->
				mins = Math.floor val/60
				secs = val - mins * 60
				if secs < 10 then secs = '0' + secs
				mins + ':' + secs

			# On / Off counter
			$scope.toggleCounter = () ->
				requestNotificationPermission()
				if $scope.isActive
					$scope.$emit 'counterStart'
					if work is true then setBackground(2) else setBackground(1)
					countDown()
				else
					$scope.$emit 'counterStop'
					setBackground 3
					stop()
				$scope.isActive = !$scope.isActive

			#
			$scope.initializeWindowSize()
			setBackground 2

			angular.element($window).bind 'resize', ->
				$scope.initializeWindowSize()
				$scope.$apply()

