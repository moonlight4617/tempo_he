class ApplicationController < ActionController::Base
  include ApplicationHelper

  def before_login_user
    if session[:user_id] == nil
      store_location
      redirect_to user_login_path
    end
  end

  def before_login_owner
    if session[:owner_id] == nil
      store_location
      redirect_to owner_login_path
    end
  end

end
