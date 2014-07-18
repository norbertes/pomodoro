'use strict'

###*
 # @ngdoc directive
 # @name pomodoroApp.directive:settings
 # @description
 # # settings
###
angular.module('pomodoroApp')
	.directive 'settings', ->
		templateUrl: 'views/settings.html'
		restrict: 'E'
		controllerAs: 'SettingsCtrl'
		controller: ($scope) ->
			settingsVisible = false
			bgColor1 = '#12538B'
			bgColor2 = '#449d44'
			bgColor3 = '#414141'

			$scope.volume = 75 # Notifications volume
			$scope.workBg = bgColor2

			$scope.$on 'counterStart', ->
				checkToggle()
			$scope.$on 'counterStop', ->
				checkToggle()

			#
			checkToggle = ->
				if settingsVisible is true
					$scope.toggle()

			# show/hide settings menu
			$scope.toggle = ->
				$scope.$emit 'stopCounter'
				settingsVisible = not settingsVisible
				$('.settings-ico').toggle()
				$('.settings').toggleClass 'settings-rolled'
				$('.wrapper').toggleClass 'wrapper-rolled'

			# Set background color
			$scope.setBgColor = (val) ->
				$scope.workBg = val
				$scope.$emit 'changeBg', val

			# Change volume
			$scope.$watch 'volume', ->
				$scope.volume = parseFloat $scope.volume
