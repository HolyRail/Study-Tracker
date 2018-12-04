class DashboardController < ApplicationController
  def index
    @current_user ||= User.find_by_id(session[:user_id])
    subjects = @current_user.subjects
    @out_subjects = []
    subjects.each do |subject|
      out_subject = Hash.new
      out_subject['name'] = subject.name
      schedules = subject.schedules
      study_session_count = 0
      study_completed_count = 0
      out_subject['schedules'] = []
      schedules.each do |schedule|
        study_session_count += 1
        if schedule.completed
          study_completed_count += 1
        end
        schedule_nc = Hash.new
        schedule_nc['day'] = day_to_string(schedule.day_of_week)
        schedule_nc['completed'] = schedule.completed
        schedule_nc['start_time'] = schedule.start_time.time.strftime("%I:%M%p")
        schedule_nc['end_time'] = schedule.end_time.time.strftime("%I:%M%p")
        out_subject['schedules'].push(schedule_nc)
      
      end
      out_subject['completion_rate'] = (study_completed_count/study_session_count)*100
      print out_subject
      @out_subjects.push(out_subject)
    end
  end
  
  def day_to_string(day_of_week)
    case day_of_week
      when 1 then day = "Monday"
      when 2 then day = "Tuesday"
      when 3 then day = "Wednesday"
      when 4 then day = "Thursday"
      when 5 then day = "Friday"
      when 6 then day = "Saturday"
      when 7 then day = "Sunday"
    end
    return day
  end
end
