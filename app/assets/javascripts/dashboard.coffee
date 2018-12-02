flipcard = ->
    current_id = parseInt($(this).prop('id').match(/\d+/g), 10)
    $('#card-'+current_id).addClass('is-flipped')
    return

reflipcard = ->
    current_id = parseInt($(this).prop('id').match(/\d+/g), 10)
    $('#card-'+current_id).removeClass('is-flipped')
    return
    
changelabel = ->
    current_id = $(this).prop('id').match(/\d+-\d+/g)[0]
    if $('#switch-label-text-' + current_id).html() == "Not Completed"
        $('#switch-label-text-' + current_id).html("Completed")
    else
        $('#switch-label-text-' + current_id).html("Not Completed")

$(document).ready ->
 $ ->
   $('button[id^=update').on 'click', flipcard
   return
 $ ->
   $('input[id^=switch').on 'click', changelabel
   return
 $ ->
   $('button[id^=cancel').on 'click', reflipcard
   return
 return
return