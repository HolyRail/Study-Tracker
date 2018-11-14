copyschedule = ->
  $div = $('div[id^="single-schedule"]:last')
  num = parseInt($div.prop('id').match(/\d+/g), 10) + 1
  $div_orig = $('div[id="single-schedule-0"]:first')
  $newsched = $div_orig.clone().prop('id', 'single-schedule-' + num)
  $div_current = this.closest('div[id^="single-subject"]')
  parent_header = $div_current.id
  $last_form = $("#" + parent_header).find('div[id^="single-schedule"]:last')
  $last_form.after $newsched
  return

deleteschedule = ->
  $div_current = this.closest('div[id^="single-subject"]')
  parent_header = $div_current.id
  $div = $("#" + parent_header).find('div[id^="single-schedule"]:last')
  if parseInt($div.prop('id').match(/\d+/g), 10) > 1
    $div.remove()
  return

copysubject = ->
  $div = $('div[id^="single-subject"]:last')
  num = parseInt($div.prop('id').match(/\d+/g), 10) + 1
  $div_orig = $('div[id="single-subject-0"]')
  $newsched = $div_orig.clone().prop('id', 'single-subject-' + num)
  $newsched.find('.btn-copy').on 'click', copyschedule
  $newsched.find('.btn-delete').on 'click', deleteschedule
  $div.after $newsched
  return

validateStartDate = ->
  alert("validateStartDate")
  dateString = document.getElementById('startdate').value
  startDate = new Date(dateString)
  today = new Date
  if startDate < today
    $('#startdate').after '<p>You sure, you can time travel?.</p>'
    return false
  true

validateEndDate = ->
  alert("validateEndDate")
  dateString = document.getElementById('enddate').value
  endDate = new Date(dateString)
  dateString = document.getElementById('startdate').value
  startDate = new Date(dateString)
  if endDate < startDate
    $('#enddate').after '<p>Wah Modiji Wah!</p>'
    return false
  true

parseAndValidate = ->
  formObj = parseForm()
  if validate(formObj)
    #send to controller
  else
    #display error
    
parseForm = ->
  formObj = {}
  formObj['subjects'] = []
  $subjects = $('div[id^="single-subject"]')
  i = 1
  while i < $subjects.length
    temp_subj = {}
    
    $('#' + $subjects[i].id).find('div[id="subject"]')
    i++
  
    
$(document).ready ->
 $ ->
   $('button[class*=btn-copy]').on 'click', copyschedule
   return
 $ ->
   $('.btn-delete').on 'click', deleteschedule
   return
 $ ->
   $('.btn-subject').on 'click', copysubject
 $ ->
   $('.btn-submit').on 'click', parseAndValidate
   return
 return
return