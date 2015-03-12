# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  return if $("#map").length == 0

  L.mapbox.accessToken = 'pk.eyJ1IjoiaGFuaWVsZGFuc29uIiwiYSI6IkFocjdTOUUifQ.xyT3gJjivbRhXnxojbrUHg'
  map = L.mapbox.map('map', 'hanieldanson.ldep8j96')
  myLayer = L.mapbox.featureLayer().addTo(map)
  if queryParamValue("meetup_id")
    url = "/maps.json?meetup_id=" + queryParamValue("meetup_id")
    $('#map_nearby').hide()
  else
    url = "/maps"

  $.ajax
    type: 'GET'
    url: url
    dataType: 'json'
    success: (data) ->
      # add custom popups to each marker
      myLayer.on 'layeradd', (e) ->
        marker = e.layer
        properties = marker.feature.properties
        # create custom popup
        popupContent =  '<div class="popup">' +
          '<h3>' +'<b>Meetups at:</b> </br>' + 
          properties.name + ' Library</h3>' +
          # '<p>' + properties.meetup_url + ' Library</p>' +
          # '<h4> Meetups at this Location:</h4>' +
          '<ul class="meetups">' +
          properties.meetup_urls.map (url) ->
             return '<li class="meetups">' + url + '</li>'
          .join("") +
          '</ul>' +
          '</div>'
        # http://leafletjs.com/reference.html#popup
        marker.bindPopup(popupContent).openPopup()
      myLayer.setGeoJSON(data)


window.queryParamValue = (val) ->
  result = null
  tmp = []
  items = location.search.substr(1).split('&')
  index = 0
  while index < items.length
    tmp = items[index].split('=')
    if tmp[0] == val
      result = decodeURIComponent(tmp[1])
    index++
  result

