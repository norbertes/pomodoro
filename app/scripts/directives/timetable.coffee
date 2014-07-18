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
				pt1px = ''
				if type is 'work'
					pic = 'images/pomodoro.png'
					pt1px = ' style="padding-top:1px;"'
				else
					cnt = $scope.timeTable.filter (val) -> val.type is 'break'
					if cnt.length % 4 is 0
						pic = 'images/dinner.png'
					else
						pic = 'images/coffee.png'
				div = '<div class="icon-pos" '+pt1px+'><img src="'+pic+'" /></div>'
				$('.js-timetable').append div

			$scope.$on 'addWork', ->
				addToTimetable 'work'

			$scope.$on 'addBreak', ->
				addToTimetable 'break'

			# $scope.$watchCollection 'timeTable', (arr) ->
			# 	allPos = ''
			# 	arr.map (pos) =>
			# 		allPos += pos.type + ', '
			# 	$('.js-timetable').html allPos
