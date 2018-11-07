
$(document).ready ->
 $ ->
   $('.btn-copy').on 'click', ->
     ele = $(this).closest('.div1').clone(true)
     #var ele = $(this).getElementById('div1').clone(true);
     $(this).closest('.div1').after ele
     return
   return
 $ ->
   $('.btn-delete').on 'click', ->
     #alert($(this).closest('.div1').closest('.add').children().length)
     if $(this).closest('.div1').closest('.add').children().length > 1
       $(this).closest('.div1').remove()
     return
   return
 return

