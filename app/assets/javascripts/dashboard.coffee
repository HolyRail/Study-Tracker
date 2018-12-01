flipcard = ->
    $('.card').css("transform", "rotateY(180deg)")
    return

$(document).ready ->
 $ ->
   $('#update').on 'click', flipcard
   return
 return
return