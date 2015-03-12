$(document).ready ->
  $('.hidden_meetups_nearby li').hide()
  $(document).on 'ready', ->
  $(document).on 'click', '.chevron_nearby', (event) ->
    if ($('.hidden_meetups_nearby li').text().length > 0)
      $('.hidden_meetups_nearby li').slideToggle("slow")
      $(event.target).toggleClass 'fa-chevron-up fa-chevron-down'
      $('.meetups_nearby_header').toggle()
    return
  $(document).on 'click', '.chevron_completed', (event) ->
    if ($('.hidden_completed_courses li').text().length > 0)
      $('.hidden_completed_courses li').slideToggle("slow")
      $(event.target).toggleClass 'fa-chevron-up fa-chevron-down'
      $('.completed_courses_header').toggle()
    return
  return

