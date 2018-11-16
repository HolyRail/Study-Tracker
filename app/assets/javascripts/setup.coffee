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
  
  $.ajax
    type: 'POST'
    url: '../setup/create'
    data: formObj
    dataType: 'text'
    success: (resultData) ->
      alert 'Save Complete!'
  return
  alert 'Save Incomplete!'
  #sample formObj
  # formObj = {
  #   subjects : [{
  #     end_date: "2018-11-02",
  #     hours: "1",
  #     name: "Physics"
  #     schedules: [{
  #         day: "mon",
  #         start: "11:11",
  #         end: "12:35"
  #       },{
  #         day: "tue",
  #         start: "23:12",
  #         end: " 23:35"
  #       }]
  #     },{
  #     end_date: "2018-11-03",
  #     hours: "1",
  #     name: "Chemsitry"
  #     schedules: [{
  #         day: "wed",
  #         start: "1:11",
  #         end: "13:35"
  #       },{
  #         day: "thur",
  #         start: "4:12",
  #         end: " 5:35"
  #       },{
  #         day: "fri",
  #         start: "2:12",
  #         end: " 3:35"
  #       }]
  #     }]
  # }
    
parseForm = ->
  formObj = {}
  formObj['subjects'] = []
  subjects = $('div[id^="single-subject"]')
  i = 1
  while i < subjects.length
    temp_subj = {}
    subject = $(subjects[i])
    temp_subj['name'] = subject.find('input[id="subject"]').val()
    temp_subj['hours'] = subject.find('input[id="hours"]').val()
    temp_subj['start_date'] = subject.find('input[id="startdate"]').val()
    temp_subj['end_date'] = subject.find('input[id="enddate"]').val()
    temp_subj['schedules'] = []
    schedules = subject.find('div[id^="single-schedule"]')
    j=1
    while j < schedules.length
      temp_sched = {}
      schedule = $(schedules[j])
      temp_sched['day'] = schedule.find('select[id="day"]').val()
      temp_sched['start'] = schedule.find('input[id="starttime"]').val()
      temp_sched['end'] = schedule.find('input[id="endtime"]').val()
      temp_subj['schedules'].push(temp_sched)
      j++
    formObj['subjects'].push(temp_subj)
    i++
  return formObj
  
    
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