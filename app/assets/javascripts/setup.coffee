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

validateStartDate = (startDate) ->
  # validate that date entered is not in past
  today = new Date
  
  if startDate == ""
    console.log("startDate is invalid")
    return false
  
  startDate = new Date(startDate)
  
  if startDate < today
    console.log("You sure, you can time travel")
    #$('#startdate').after '<p>You sure, you can time travel?.</p>'
    return false
  true

validateEndDate = (endDate, startDate) ->
  
  if endDate == ""
    console.log("endDate is invalid")
    return false
  
  startDate = new Date(startDate)
  endDate = new Date(endDate)  
  
  if endDate < startDate
    console.log("endDate less than startDate")
    #$('#enddate').after '<p>Wah Modiji Wah!</p>'
    return false
  true
  
validateSubjectName = (subject) ->
  if subject == ""
    console.log("subject is invalid")
    #$('#subject').after '<p>Empty, eh? </p>'
    return false
  true  
  
validateHours = (hours) ->
  if hours == "" || hours <= 0
    console.log("hours can not be empty")
    return false
  true  

totalHours = 0
totalHoursAllocated = (end, start) ->
  # As Professor Bettati would say, this is programming at the level of a baboon
  # but the following hacky way gets us the time difference
  
  timeStart = new Date('01/01/2007 ' + start).getHours()
  timeEnd = new Date('01/01/2007 ' + end).getHours()
  hourDiff = timeEnd - timeStart 
  # collect hours
  totalHours += hourDiff  
  
validateHoursAllocated = (hours) ->
  if totalHours != hours
    console.log("hours are not consistent")
    totalHours = 0
    return false
  totalHours = 0
  true  
  
parseAndValidate = ->
  formObj = parseForm()
  validate(formObj)
  #if validate(formObj)
    #send to controller
  #else
    #display error

validate = (formObj) ->
  json_s = JSON.stringify(formObj)
  json = JSON.parse(json_s)
  i = 0                                       # to iterate subjects

  while i < json.subjects.length
    
    subject = json.subjects[i].name
    validateSubjectName(subject)
    
    startDate = json.subjects[i].start_date
    validateStartDate(startDate)
    
    endDate = json.subjects[i].end_date
    validateEndDate(endDate, startDate)
    
    hours = json.subjects[i].hours
    validateHours(hours)
    
    schedules = json.subjects[i].schedules
    j = 0                                     # to iterate schedules
    diff = 0                                  # will collect total hours
    while j < schedules.length
      # total time should be equal to 'hours' alloted
      totalHoursAllocated(schedules[j].end, schedules[j].start)
      j++
    
    validateHoursAllocated(hours)
      
    i++
  
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