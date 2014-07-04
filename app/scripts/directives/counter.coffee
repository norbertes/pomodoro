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
			$scope.pomodoroTime = 60*25	# Czas trwania pomodoro
			$scope.shortBreak = 60*5	# Czas trwania krótkiej przerwy
			$scope.longBreak = 60*25	# Czas trwania długiej przerwy
			$scope.counter 	= $scope.pomodoroTime	# Czas na liczniku (init = czas pomodoro)
			$scope.isActive = true		# Czy zegrar chodzi
			$scope.timeTable = []		# Tabela z datami zakończeń pomodoro
			$scope.volume = 0.75		# Głośność
			mytimeout = false			# Zmienna do countera
			work = true 				# work = true, break = false

			# resize okna
			$scope.initializeWindowSize = ->
				$scope.windowHeight = $window.innerHeight
				$scope.windowWidth  = $window.innerWidth
				$scope.paddingTop = $window.innerHeight * 0.2

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

			setBackground = (val) ->
				if val is 1
					bgColor = '#428bca'
				else if val is 2
					bgColor = '#449d44'
				else if val is 3
					bgColor = '#ec971f'

				$('body').css 'background',bgColor

			setNotification = (val) ->
				if val is 1
					notify = new Notify 'Pomodoro',
						body: 'Czas na przerwę!'
						icon: 'images/tomato.jpeg'
						timeout: 10
					.show()
				else if val is 2
					notify = new Notify 'Pomodoro',
						body: 'Koniec przerwy!'
						icon: 'images/tomato.jpeg'
						timeout: 10
					.show()
				else if val is 3
					notify = new Notify 'Pomodoro',
						body: 'Alert!'
						icon: 'images/tomato.jpeg'
						timeout: 10
					.show()

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
					# console.log $scope.timeTable.length
					# if $scope.timeTable.length % 4 is 0 then brk = 'longbreak' else brk = 'break'
					# $scope.timeTable.push {date: Date.now(), type: 'break'}
					setBackground 2
					setNotification 2
					$scope.counter = $scope.pomodoroTime
				else
					$scope.timeTable.push {date: Date.now(), type: 'work'}
					setBackground 1
					if $scope.timeTable.length % 4 is 0
						$scope.counter = $scope.longBreak
						setNotification 1
					else
						$scope.counter = $scope.shortBreak
						setNotification 1

			# Odliczanie
			countDown = () ->
				$scope.counter--
				if $scope.counter > 0
					mytimeout = $timeout countDown,1000
				else
					setAction()

			# Odtwarzanie dźwięku
			playSound = ->
				unless $scope.volume
					snd = new Audio '../sounds/success.wav'
					snd.volume = $scope.volume
					snd.play()

			# Metoda do formatowania godziny w liczniku
			$scope.formatCounter = (val) ->
				mins = Math.floor val/60
				secs = val - mins * 60
				if secs < 10 then secs = '0' + secs
				mins + ':' + secs

			# Włącznik / wyłącznik licznika
			$scope.toggleCounter = () ->
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

