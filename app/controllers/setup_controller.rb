class SetupController < ApplicationController
  def index
    @current_user ||= Users.find_by_id(session[:user_id])
  end
end
