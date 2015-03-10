# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  return if $("#map").length == 0

  L.mapbox.accessToken = 'pk.eyJ1IjoiaGFuaWVsZGFuc29uIiwiYSI6IkFocjdTOUUifQ.xyT3gJjivbRhXnxojbrUHg'
  map = L.mapbox.map('map', 'hanieldanson.ldep8j96')
  myLayer = L.mapbox.featureLayer().addTo(map)

  $.ajax
    type: 'GET'
    url: '/maps'
    dataType: 'json'
    success: (data) ->
