class EvaluationsController < ApplicationController

  include UserSessionsHelper
  include OwnerSessionsHelper

  def new
    if current_user.present?
      @evaluated = Shop.find(params[:id])
      @evaluation = Evaluation.new
    elsif current_owner.present?
      @evaluated = User.find_by(public_uid: params[:user])
      @evaluation = Evaluation.new
    end
  end

  def create
    if current_user.present?
      @evaluated = Shop.find(params[:id])
      evaluate = current_user.evaluations.build(eva_params)
      evaluate.shop_id = params[:id]
      evaluate.toshop = 1
      if evaluate.save
        flash[:success] = "評価が完了しました"
        redirect_to u_show_path(current_user)
      else
        flash.now[:warning] = "評価ができませんでした"
        render 'new'
      end
    elsif current_owner.present?
      @evaluated = User.find_by(public_uid: params[:evaluation][:user])
      evaluate = Shop.find(params[:id]).evaluations.build(eva_params)
      
      # 後ほど修正
      evaluate.user_id = @evaluated.id
      if evaluate.save
        flash[:success] = "評価が完了しました"
        redirect_to o_show_path
      else
        flash.now[:warning] = "評価ができませんでした"
        render 'new'
      end
    end
  end

  private
    def eva_params
      params.require(:evaluation).permit(:rate, :comment)
    end
end
