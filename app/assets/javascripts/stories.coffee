# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = () ->
  $( '.current_story' ).change ->

    if $( 'input:checked' ).length > 0

      story = $(this)
      story_id = $(this)[0].value
      status = $(this).is(':checked')

      request = $.post "/stories/#{story_id}/change_current_story?status=#{status}"
      request.success (data) ->  Turbolinks.visit(window.location.toString(), { action: 'replace' })
      request.error (jqXHR, textStatus, errorThrown) -> alert( 'Server error' )

    else
      $(this).prop('checked', true);

$(document).on 'turbolinks:load', ready