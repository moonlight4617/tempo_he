class FavoriteController < ApplicationController
  before_action :set_shop

  include UserSessionsHelper
  include OwnerSessionsHelper

  def create
    Favorite.create(user_id: current_user.id, shop_id: params[:id])
    # respond_to do |format|
    #   format.html { redirect_to s_index_path }
    #   format.js
    # end
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, shop_id: params[:id]).destroy
    # respond_to do |format|
    #   format.html { redirect_to s_index_path }
    #   format.js
    # end
  end

  private
    def set_shop
      @shop = Shop.find(params[:id])
    end
end
