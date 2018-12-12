errorList = [] 
    
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
  
deletesubject = ->
  div_current = $('div[id^="single-subject"]:last')
  parent_header = div_current.prop("id")
  if parseInt(parent_header.match(/\d+/g), 10) > 1
    div_current.remove()
  return
  

dateToday = ->
  today = new Date
  dd = today.getDate()
  mm = today.getMonth() + 1
  #January is 0!
  yyyy = today.getFullYear()
  if dd < 10
    dd = '0' + dd
  if mm < 10
    mm = '0' + mm
  today = yyyy + '-' + mm + '-' + dd
  return today
  
validateStartDate = (startDate) ->
  # validate that date entered is not in past
  today = dateToday()
    
  if startDate == ""
    errorList.push "Start date is empty."
    return false
  
  if startDate < today
    errorList.push "Start date is in the past!"
    #$('#startdate').after '<p>You sure, you can time travel?.</p>'
    return false
  true

validateEndDate = (endDate, startDate) ->
  
  if endDate == ""
    errorList.push "End date can not be empty"
    return false
  
  if endDate < startDate
    errorList.push "End date can not be less than start date"
    #$('#enddate').after '<p>Wah Modiji Wah!</p>'
    return false
  true
  
validateSubjectName = (subject) ->
  if subject == ""
    errorList.push "Subject field can not be empty"
    #$('#subject').after '<p>Empty, eh? </p>'
    return false
  true  
  
validateHours = (hours) ->
  if hours == "" || hours <= 0
    errorList.push "hours field can not be empty"
    return false
  true  

totalHours = 0
totalHoursAllocated = (end, start) ->
  # As Professor Bettati would say, this is programming at the level of a baboon
  # but the following hacky way gets us the time difference
  timeStart = new Date('01/19/2038 ' + start).getHours()
  timeEnd = new Date('01/19/2038 ' + end).getHours()
  # the end is near
 
  hourDiff = timeEnd - timeStart 
  # collect hours
  totalHours += hourDiff
  
validateHoursAllocated = (hours) ->
  if totalHours != parseInt(hours)
    errorList.push "Total hours are not consistent."
    totalHours = 0
    return false
  totalHours = 0
  true  
  
parseAndValidate = ->
  formObj = parseForm()
  ###
  formObj = {
      subjects : [{
        end_date: "2018-11-02",
        hours: "1",
        name: "Physics"
        schedules: [{
            day: "mon",
            start: "11:11",
            end: "12:35"
          },{
            day: "tue",
            start: "23:12",
            end: " 23:35"
          }]
        },{
        end_date: "2018-11-03",
        hours: "1",
        name: "Chemsitry"
        schedules: [{
            day: "wed",
            start: "1:11",
            end: "13:35"
          },{
            day: "thur",
            start: "4:12",
            end: " 5:35"
          },{
            day: "fri",
            start: "2:12",
            end: " 3:35"
          }]
        }]
    }
  ###
  errorList = []
  errorText = ''
  $('#error1').remove()
  if validate(formObj)
    #send to controller
    $.ajax
      type: 'POST'
      url: '../setup/create'
      data: formObj
      dataType: 'text'
      success: (resultData) ->
        window.location.replace("../dashboard/index");
    return
  else
    error = 0
    errorText = '<li id="error1">' 
    while error < errorList.length
      errorText += '<span> '+ errorList[error] + '</span>'
      error++
    errorText+= '</li>'
    $('#error').after(errorText)

    #alert 'Totally unproductive error message'



validate = (formObj) ->
  json_s = JSON.stringify(formObj)
  json = JSON.parse(json_s)
  i = 0                                       # to iterate subjects
  while i < json.subjects.length

    subject = json.subjects[i].name
    if(!validateSubjectName(subject))
      return false
    
    hours = json.subjects[i].hours
    if(!validateHours(hours))
      return false
      
    startDate = json.subjects[i].start_date
    if(!validateStartDate(startDate))
      return false
      
    endDate = json.subjects[i].end_date
    if(!validateEndDate(endDate, startDate))
      return false
  
    schedules = json.subjects[i].schedules
    j = 0                                     # to iterate schedules
    diff = 0                                  # will collect total hours
    while j < schedules.length
      # total time should be equal to 'hours' alloted
      totalHoursAllocated(schedules[j].end, schedules[j].start)
      j++
    
    if(!validateHoursAllocated(hours))
      return false
      
    i++
    
  return true  

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
   $('.btn-del-subject').on 'click', deletesubject   
 $ ->
   $('.btn-submit').on 'click', parseAndValidate

   return
 return
return