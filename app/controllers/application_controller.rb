class ApplicationController < ActionController::Base
  include ApplicationHelper

  def before_login_user
    if session[:user_id] == nil
      store_location
      redirect_to user_login_path
    end
  end

  def before_login_owner
    if session[:owner_id] != nil
      true
    elsif current_user.admin == 1
      true
    else
      flash[:info] = "ログインしてください"
      store_location
      redirect_to owner_login_path
    end
  end

end
