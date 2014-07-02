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
			$scope.$watchCollection 'timeTable', (newCol) ->
				allPos = ''
				console.log "newCol: #{JSON.stringify newCol}"
				newCol.map (pos) =>
					console.log 'pos: ' + JSON.stringify pos
					allPos += pos.type + ', '
				$('.js-timetable').html allPos
