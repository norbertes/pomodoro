'use strict'

###*
 # @ngdoc overview
 # @name pomodoroApp
 # @description
 # # pomodoroApp
 #
 # Main module of the application.
###

# Trzymać w localstorage stan pomodoro dla danego dnia
# Dodać settingsy
# Usuąć JQuery

angular
  .module('pomodoroApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        # templateUrl: 'views/main.html'
        controller: 'CounterCtrl','timeTableCtrl'
      .otherwise
        redirectTo: '/'

