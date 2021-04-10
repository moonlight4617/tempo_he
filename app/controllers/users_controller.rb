class UsersController < ApplicationController

  include UserSessionsHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :user_exist?, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "ユーザー登録されました"
      redirect_to u_show_path(@user)
    else
      render 'new'
    end
  end

  def show
    # @calendars = Calendar.where(user_id: session[:user_id]).select(:shop_id).distinct

    @calendars = Calendar.where(user_id: session[:user_id])
    shop_id = @calendars.select(:shop_id).distinct.pluck(:shop_id)
    @newest_reserve = []
    shop_id.each do |shop|
      @newest_reserve.push(@calendars.where(shop_id: shop).order(:rent_date).last)
    end

    # @newest_calendars = Calendar.where(user_id: session[:user_id]).order(:rent_date).last

    # @oldest_calendars = Calendar.where(user_id: session[:user_id]).order(rent_date: "DESC").last

  end

  def edit
    @user = @current_user
  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報が更新されました"
      redirect_to u_show_path
    else
      render 'new'
    end
  end

  def destroy
    @user.update(del_flg: 1)
    flash[:info] = "ユーザー情報は削除されました"
    log_out
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :address, :tel, :email, :password, :password_confirmation,:image)
    end

    def set_user
      @user = User.find_by(id: session[:user_id])
    end

    def user_exist?
      if @user == nil || @user.del_flg == 1
        redirect_to root_path
        flash[:warning] = "ログインまたは新規登録してください"
      else
        current_user
      end
    end
end
