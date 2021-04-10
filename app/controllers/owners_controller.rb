class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :edit, :update, :destroy]
  before_action :owner_exist?, only: [:show, :edit, :update, :destroy]

  include OwnerSessionsHelper

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      session[:owner_id] = @owner.id
      flash[:success] = "オーナー登録されました"
      redirect_to s_new_path
    else
      render 'new'
    end
  end

  def show
    @shops = @owner.shops
  end

  def edit
  end

  def update
    if @owner.update(owner_params)
      flash[:success] = "オーナー情報が更新されました"
      redirect_to o_show_path
    else
      render 'new'
    end
  end

  def destroy
    @owner.update(del_flg: 1)
    flash[:info] = "オーナー情報は削除されました"
    log_out_owner
    redirect_to root_path
  end

  private

    def owner_params
      params.require(:owner).permit(:name, :address, :tel, :email, :password, :password_confirmation)
    end

    def set_owner
      @owner = Owner.find_by(id: session[:owner_id])
    end

    def owner_exist?
      if @owner == nil || @owner.del_flg == 1
        redirect_to root_path
        flash[:warning] = "ログインまたは新規登録してください"
      else
        current_owner
      end
    end
end
