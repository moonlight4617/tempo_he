class UserSessionsController < ApplicationController

  include UserSessionsHelper
  include OwnerSessionsHelper

  def new
  end

  def create
    @user = User.find_by(email: params[:user_session][:email].downcase)
    if @user && @user.del_flg == 1
        @user = nil
        flash[:warning] = "すでに削除されたアカウントです"
        redirect_to root_path
    elsif @user && @user.authenticate(params[:user_session][:password])
      session[:user_id] = @user.id
      if session[:owner_id]
        @owner = Owner.find(session[:owner_id])
        session.delete(:owner_id)
        forget_owner(@owner)
      end
      params[:user_session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or(s_index_path)
    else
      flash.now[:danger] = 'Eメールまたはパスワードが有効のものではありません'
      render 'new'
    end
  end

  def logout
    if logged_in?
      @user = User.find(session[:user_id])
      log_out
      redirect_to root_url
    end
  end

  def sample_user
    @user = User.find_by(email: "sample_user@gmail.com")
    session[:user_id] = @user.id
    if session[:owner_id]
      @owner = Owner.find(session[:owner_id])
      session.delete(:owner_id)
      forget_owner(@owner)
    end
    redirect_back_or(s_index_path)
  end
end
