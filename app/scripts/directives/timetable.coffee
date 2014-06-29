'use strict'

###*
 # @ngdoc directive
 # @name pomodoroApp.directive:timeTable
 # @description
 # # timeTable
###
angular.module('pomodoroApp')
	.directive 'timeTable', ->
		templateUrl: 'views/timetable.html'
		className: 'footer-bar-btns visible-xs'
		restrict: 'E'
		controllerAs: 'timeTableCtrl'
		controller: ($scope) ->
			$scope.$on 'counterStart', ->
				console.log "start: #{$scope.timeTable.length}"
			$scope.$on 'counterStop', ->
				console.log "stop: #{$scope.timeTable.length}"
