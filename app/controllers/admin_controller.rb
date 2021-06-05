class AdminController < ApplicationController

  before_action :correct_administrator

  def user_index
    @users = User.all
  end

  def user_individual
    @user = User.find_puid(params[:format])
  end

  def user_edit
    @user = User.find_puid(params[:format])
  end

  def user_update
    @user = User.find_puid(params[:user][:id])
    if @user.update(user_params)
      flash[:success] = "ユーザー情報が更新されました"
      redirect_to admin_user_ind_path(@user)
    else
      render 'user_edit'
    end
  end

  def user_destroy
    @user = User.find_puid(params[:format])
    @user.del_flg = 1
    @user.save
    flash[:success] = "ユーザーが削除されました"
    redirect_to admin_user_path
  end

  def owner_index
    @owners = Owner.all
  end

  def shop_show
    @shop = Shop.find(params[:id])
    @tags = @shop.tags
  end

  def shop_edit
    @shop = Shop.find(params[:id])
  end

  def shop_update
    @shop = Shop.find(params[:id])
    set_business_time
    if @shop.update(shop_params) && params[:shop][:tags]
      params[:shop][:tags].each do |tag|
        shop_tag = TagToShop.new(shop_id: @shop.id, tag_id: tag)
        shop_tag.save
      end
      flash[:success] = "店舗情報は更新されました"
      redirect_to admin_shop_path(@shop)
    elsif @shop.update(shop_params)
      flash[:success] = "店舗情報は更新されました"
      redirect_to admin_shop_path(@shop)
    else
      flash[:danger] = "情報が正しくありません"
      render 'shop_edit'
    end
  end

  private
    def correct_administrator
      if User.find(session[:user_id]).admin != 1
        flash[:danger] = "管理者権限がありません"
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(:name, :address, :tel, :email, :password, :password_confirmation,:image)
    end

    def shop_params
      # tag_to_shops_attributes必要ない？
      params.require(:shop).permit(:name, :prefecture, :city, :address, :tel, :station, :capacity, :image, :price, :content, :zip_code, :start_time, :end_time, :tags, tag_to_shops_attributes: [:id, :tag_id, :shop_id])
    end

    def set_business_time
      if params[:shop][:start_time] != "" && params[:shop][:end_time] != ""
        s_time = params[:shop][:start_time].to_i
        e_time = params[:shop][:end_time].to_i
        business_time = []  
        while s_time < e_time do
          business_time.push(s_time)
          s_time = s_time + 1
        end    
        @shop.business_time = business_time
      end
    end
end
