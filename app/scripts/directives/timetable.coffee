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

			addToTimetable = (type) ->
				if type is 'work'
					pic = '../../images/pomodoro.jpg'
				else
					cnt = $scope.timeTable.filter (val) -> val.type is 'break'
					if cnt.length % 4 is 0
						pic = '../../images/dinner.png'
					else
						pic = '../../images/coffeeicon.png'
				div = '<div class="icon-pos"><img src="'+pic+'" /></div>'
				$('.js-timetable').append div

			$scope.$on 'counterStart', ->
				console.log "start: #{$scope.timeTable.length}"

			$scope.$on 'counterStop', ->
				console.log "stop: #{$scope.timeTable.length}"

			$scope.$on 'addWork', ->
				addToTimetable 'work'

			$scope.$on 'addBreak', ->
				addToTimetable 'break'

			# $scope.$watchCollection 'timeTable', (arr) ->
			# 	allPos = ''
			# 	arr.map (pos) =>
			# 		allPos += pos.type + ', '
			# 	$('.js-timetable').html allPos
