$(document).ready ->
  $('.hidden_meetups_nearby li').hide()
  $(document).on 'ready', ->
  $(document).on 'click', '.chevron_completed', (event) ->
    if ($('.hidden_completed_courses li a').text().length > 0)
      $('.completed_courses_header').toggle()
      $('.hidden_completed_courses li').slideToggle("slow")
      $('.completed').toggleClass 'fa-chevron-up fa-chevron-down'
    return
  $(document).on 'click', '.chevron_nearby', (event) ->
    if ($('.hidden_meetups_nearby li a').text().length > 0)
      $('.meetups_nearby_header').toggle()
      $('.hidden_meetups_nearby li').slideToggle("slow")
      $('.nearby').toggleClass 'fa-chevron-up fa-chevron-down'
    return
  return

