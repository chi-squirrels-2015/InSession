$(document).ready ->
  $('.hidden_meetups_nearby li').hide()
  $(document).on 'ready', ->
  $(document).on 'click', '.chevron_nearby', (event) ->
    $('.hidden_meetups_nearby li').slideToggle("slow")
    
    return
  return

