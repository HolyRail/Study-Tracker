class DashboardController < ApplicationController
  def index
    session.delete(:user_id)
  end
end
