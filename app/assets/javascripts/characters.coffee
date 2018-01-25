# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = () ->
  $( '.characters_btn' ).click ->

    button = $(this)
    c_id = button.attr( 'c_id' )

    data = $("#character_id__#{c_id}")

    console.log( data )
#    console.log( c_id  )

    if data.val() == 'true'
      data.val('false')
    else
      data.val('true')


#    if chkbx.is(':checked')
#      console.log('checked')
#      chkbx.prop('checked', false)
#      button.removeClass('btn-primary')
#      button.addClass('btn-warning')
#    else
#      console.log('unchecked')
#      chkbx.val( true )
#      console.log( chkbx.is(':checked') )
#      console.log( button )
#      button.removeClass('btn-warning')
#      console.log( button )
#      button.addClass('btn-primary')
#      console.log( button )

#    if $( 'input:checked' ).length > 0
#
#      story = $(this)
#      story_id = $(this)[0].value
#      status = $(this).is(':checked')
#
#      request = $.post "/stories/#{story_id}/change_current_story?status=#{status}"
#      request.success (data) ->  Turbolinks.visit(window.location.toString(), { action: 'replace' })
#      request.error (jqXHR, textStatus, errorThrown) -> alert( 'Server error' )
#
#    else
#      $(this).prop('checked', true);

$(document).on 'turbolinks:load', ready