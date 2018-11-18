class SessionsController < ApplicationController
  skip_before_action :set_current_user
  def new
  end
  def create
  	@user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
  	session[:user_id] = @user.id
  	
  	#Add logic to redirect to setup if initial login and dashboard otherwise
  	redirect_to setup_index_path
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end
end
