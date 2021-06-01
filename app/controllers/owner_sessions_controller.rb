class OwnerSessionsController < ApplicationController

  include OwnerSessionsHelper
  include UserSessionsHelper

  def new
  end

  def create
    owner = Owner.find_by(email: params[:owner_session][:email].downcase)
    if owner && owner.authenticate(params[:owner_session][:password])
      session[:owner_id] = owner.id
      if session[:user_id]
        @user = User.find(session[:user_id])
        session.delete(:user_id)
        forget(@user)
      end
      params[:owner_session][:remember_owner] == '1' ? remember_owner(owner) : forget_owner(owner)
      redirect_back_or(o_show_path)
    else
      flash.now[:danger] = 'Eメールまたはパスワードが有効のものではありません'
      render 'new'
    end
  end

  def logout
    if logged_in_owner?
      @owner = Owner.find(session[:owner_id])
      log_out_owner
      redirect_to root_path
    end
  end

  def sample_owner
    @owner = Owner.find_by(email: "sample_owner@gmail.com")
    session[:owner_id] = @owner.id
    if session[:user_id]
      @user = User.find(session[:user_id])
      session.delete(:user_id)
      forget_user(@user)
    end
    redirect_back_or(s_index_path)
  end
end
