class DashboardController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  
  def index
    @current_user ||= User.find_by_id(session[:user_id])
    subjects = @current_user.subjects
    @out_subjects = []
    subjects.each do |subject|
      out_subject = Hash.new
      out_subject['name'] = subject.name
      out_subject['hours'] = subject.hours
      schedules = subject.schedules
      out_subject['schedules'] = []
      out_subject['upcoming_schedules'] = []
      schedules.each do |schedule|
        schedule_nc = Hash.new
        schedule_nc['id'] = schedule.id
        schedule_nc['day'] = day_to_string(schedule.day_of_week)
        schedule_nc['completed'] = schedule.completed
        schedule_nc['start_time'] = schedule.start_time.time.strftime("%I:%M%p")
        schedule_nc['end_time'] = schedule.end_time.time.strftime("%I:%M%p")
        out_subject['schedules'].push(schedule_nc)
        if compareDays(day_to_string(schedule.day_of_week), Date.today.strftime("%A")) and !schedule.completed
          out_subject["upcoming_schedules"].push(schedule_nc)
        end
      end
      @out_subjects.push(out_subject)
    end
  end
  
  def update
    schedules = params[:schedules]
    schedules.each do |key, schedule|
      newSched = Schedule.find_by_id((schedule["id"]).to_i)
      newSched.completed = schedule["completed"] == "true"
      newSched.save!
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
  
  def compareDays(day1, day2)
    dayArr = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    puts(day1)
    puts(dayArr.index(day1).to_s)
    puts(day2)
    puts(dayArr.index(day2).to_s)
    if dayArr.index(day1) >= dayArr.index(day2)
      return true
    end
    return false
  end
end
