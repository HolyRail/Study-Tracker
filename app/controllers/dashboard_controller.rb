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
      schedules.each do |schedule|
        study_session_count += 1
        if schedule.completed
          study_completed_count += 1
        end
      end
      print subject
      out_subject['completion_rate'] = (study_completed_count/study_session_count)*100
      @out_subjects.push(out_subject)
    end
  end
end
