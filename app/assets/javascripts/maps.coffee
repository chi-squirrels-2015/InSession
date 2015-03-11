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
      # add custom popups to each marker
      myLayer.on 'layeradd', (e) ->
        marker = e.layer
        properties = marker.feature.properties
        # create custom popup
        popupContent =  '<div class="popup">' +
          '<p>' +
          '<p>' + properties.name + ' Library</p>' +
          # '<p>' + properties.meetup_url + ' Library</p>' +
          '<h4> Meetups at this Location:</h4>' +
          '<ul class="meetups">' +
          properties.meetup_urls.map (url) ->
             return '<li class="meetups">' + url + '</li>'
          .join("") +
          '</ul>' +
          '</div>'
        # http://leafletjs.com/reference.html#popup
        marker.bindPopup(popupContent).openPopup()
      myLayer.setGeoJSON(data)
