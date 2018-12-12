class CalendarController < ApplicationController
    
    def index
        @current_user ||= User.find_by_id(session[:user_id])
        @schedules =Schedule.where(subject_id: @current_user.subjects.ids)
        @meetings = []
        @schedules.each do |meeting|
            print(meeting.inspect)
            date = find_date_from_day_of_week(meeting.day_of_week)
            dt = DateTime.new(date.year, date.month, date.day, meeting.start_time.hour, meeting.start_time.min, meeting.start_time.sec, meeting.start_time.zone)
            meeting.start_time = dt
            print(meeting.inspect)
            @meetings.push(meeting)
        end
        @month_info = Date.today.strftime("%B") + Date.today.year.to_s
        render dashboard_index_path
    end
    
    def day_to_int(day_of_week)
       case day_of_week
         when "Monday" then day = 1
         when "Tuesday" then day = 2
         when "Wednesday" then day = 3
         when "Thursday" then day = 4
         when "Friday" then day = 5
         when "Saturday" then day = 6
         when "Sunday" then day = 7
       end
       return day
      end
    
     def find_date_from_day_of_week(day_from_func)
       puts(day_from_func)
       today_date = Time.now.strftime("%F")
       day = Date.today.strftime('%A')
       int_day = day_to_int(day)
       b = day_from_func - int_day
    
    
       time = Date.today + b
       return time
     end
    
end
