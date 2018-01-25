# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = () ->
  $( '.characters_btn' ).click ->

    button = $(this)
    c_id = button.attr( 'c_id' )

    c_data = $("#character_id_#{c_id}")

    if c_data.val() == 'true'
      c_data.val('false')
      button.removeClass('btn-primary')
      button.addClass('btn-secondary')
    else
      c_data.val('true')
      button.removeClass('btn-secondary')
      button.addClass('btn-primary')

$(document).on 'turbolinks:load', ready