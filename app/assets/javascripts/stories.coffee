# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = () ->
  $( '.current_story' ).change ->

    if $( 'input:checked' ).length > 0

      story = $(this)
      story_id = $(this)[0].value
      status = $(this).is(':checked')

      $( '.current_story' ).attr('checked',false)
      story.prop('checked', true)

      $.post "/stories/#{story_id}/change_current_story?status=#{status}"

      console.log( story_id )
    else
      $(this).prop('checked', true);

$(document).on 'turbolinks:load', ready