'use strict'

###*
 # @ngdoc directive
 # @name pomodoroApp.directive:settings
 # @description
 # # settings
###
angular.module('pomodoroApp')
	.directive 'settings', ->
		# templateUrl: 'views/settings.html'
		template: '<div></div>'
		restrict: 'E'
		controllerAs: 'SettingsCtrl'
		controller: ($scope) ->
			$scope.toggle = ->
				console.log 'toggle'
				$('.settings-ico').toggle()
				$('.settings').toggleClass 'settings-rolled'
				$('.wrapper').toggleClass 'wrapper-rolled'

