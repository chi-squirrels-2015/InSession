# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  L.mapbox.accessToken = 'pk.eyJ1IjoiaGFuaWVsZGFuc29uIiwiYSI6IkFocjdTOUUifQ.xyT3gJjivbRhXnxojbrUHg'
  map = L.mapbox.map('map', 'hanieldanson.ldep8j96')
  myLayer = L.mapbox.featureLayer().addTo(map)

  $.ajax
    type: 'GET'
    url: '/users'
    dataType: 'json'
    success: (data) ->
      myLayer.setGeoJSON(data)


      # # add custom popups to each marker
      # myLayer.on 'layeradd', (e) ->
      #   marker = e.layer
      #   properties = marker.feature.properties


      #   # create custom popup
      #   popupContent =  '<div class="popup">' +
      #     '<h3>' + properties.name + '</h3>' +
      #     '<p>' + properties.address + '</p>' +
      #     '</div>'

      #     # http://leafletjs.com/reference.html#popup
      #   marker.bindPopup(popupContent).openPopup()
