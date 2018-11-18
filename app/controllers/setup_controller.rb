class SetupController < ApplicationController
  skip_before_action :verify_authenticity_token
 
  
  def index
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def day_to_int(day_of_week)
    case day_of_week
      when "mon" then day = 1
      when "tue" then day = 2
      when "wed" then day = 3
      when "thu" then day = 4
      when "fri" then day = 5
      when "sat" then day = 6
      when "sun" then day = 7
    end
    return day
  end  
  
  def create
    subjects = params[:subjects]
    subjects.each do |key,value|
      print(key,' ')
      print('VALUE ',value)
      subject = Subject.new
      subject.name = value[:name] 
      subject.start_date = value[:start_date]
      subject.end_date = value[:end_date]
      schedule_list = value[:schedules]
      subject.hours = value[:hours]
      print(subject)
      schedule_list.each do |k,v|
        print('VALUE sch',v)
        sch = Schedule.new
        #sch.hours = v[:hours]
        sch.day_of_week = v[:day]
        sch.start_time = v[:start]
        sch.end_time = v[:end]
        subject.schedules << sch
      end
      print(@current_user)
      @current_user.subjects << subject
    end  
    
    
    if @current_user.save!
      flash[:success] = "Successfully saved!"
      redirect_to dashboard_index_path
    end
  end
end
