'use strict'

###*
 # @ngdoc overview
 # @name pomodoroApp
 # @description
 # # pomodoroApp
 #
 # Main module of the application.
###
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
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .otherwise
        redirectTo: '/'

