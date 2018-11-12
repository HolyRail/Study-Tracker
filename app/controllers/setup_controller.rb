class SetupController < ApplicationController
  skip_before_action :verify_authenticity_token
   
  
  def index
    @current_user ||= Users.find_by_id(session[:user_id])
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
    print("HELLO")
    print(params)
    @subject = Subjects.new
    @subject.name = params[:name]
    @subject.start_date = params[:start_date]
    @subject.end_date = params[:end_date]
    @subject.users_id = @current_user.id
    
    @schedule = Schedules.new
    @schedule.hours = params[:hours]
    @schedule.day_of_week = params[:day_of_week].to_i
    @schedule.subjects_id = @subject.id
    
    
    @schedule.save
    
    if @subject.save and @current_user.update_attributes(:phone_no => params[:phone_no])
      flash[:success] = "Successfully saved!"
      redirect_to dashboard_index_path
    end
  end
end
