subjects = {}
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

timeDifference = (timeA, timeB) ->
    timeDiff = stringToTime(timeB) - stringToTime(timeA)
    timeDiff = Math.floor(timeDiff / 1000 / 60)
        
stringToTime = (strTime) ->
    hours = parseInt(strTime.slice(0,2))
    if strTime.slice(5,7) == "PM"
        hours = if hours == 12 then hours else hours + 12
        outTime = new Date(2000, 0, 1,hours, parseInt(strTime.slice(3,5)))
    else
        hours = if hours == 12 then 0 else hours
        outTime = new Date(2000, 0, 1,  hours, parseInt(strTime.slice(3,5)))

doUpdate = ->
    formObj = {}
    current_id = parseInt($(this).prop('id').match(/\d+/g), 10) - 1
    subject = subjects[current_id]
    i = 0
    formObj["schedules"] = []
    while i < subject.schedules.length
        schedule = subject.schedules[i]
        checkVal = $("#switch-" + (current_id + 1) + "-" + (i + 1)).prop("checked")
        outSchedule = {"id" : parseInt(schedule.id), "completed": checkVal}
        subjects[current_id].schedules[i].completed = checkVal
        formObj["schedules"].push(outSchedule)
        i++
    console.log(formObj)
    $.ajax
      type: 'POST'
      url: '../dashboard/update'
      data: formObj
      dataType: 'text'
      success: (resultData) ->
        setWeeklyCompletion()
        $('#card-'+(current_id+1)).removeClass('is-flipped')
    return
    
setWeeklyCompletion = ->
    i = 0
    while i < subjects.length
        subject = subjects[i]
        totalHours = subject.hours*60
        completedHours = 0
        j = 0
        while j < subject.schedules.length
            schedule = subject.schedules[j]
            if schedule.completed
                completedHours += timeDifference(schedule.start_time, schedule.end_time)
            j++
        subjects[i]["completedHours"] = completedHours
        weeklyCompletion = Math.round((completedHours/totalHours)*100)
        $("#left-chart-label-" + (i+1)).html(weeklyCompletion + "%")
        $("#left-donut-segment-" + (i+1)).css("stroke-dasharray", weeklyCompletion + " " + (100-weeklyCompletion))
        i++

$(document).ready ->
 subjects = ($('#trackers').data('trackers'))
 setWeeklyCompletion()
 $ ->
   $('button[id^=update').on 'click', flipcard
   return
 $ ->
   $('input[id^=switch').on 'click', changelabel
   return
 $ ->
   $('button[id^=cancel').on 'click', reflipcard
   return
 $ ->
   $('button[id^=do-update').on 'click', doUpdate
   return
 return
return