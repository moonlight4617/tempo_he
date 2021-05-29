class ChatsController < ApplicationController
  before_action :set_shop, except: :index_for_user
  before_action :set_chat, only: :show
  before_action :set_current_user, only: [:message, :index_for_user]


  # ユーザーから見た各オーナーとの個別チャット
  def show
    if @chat != nil
      @messages = Message.where(chat_id: @chat.id)
    end
  end

  # ユーザーから見たチャット一覧
  def index_for_user
    @chats = Chat.where(user_id: @current_user)
  end

  # オーナーに来ているチャット全て
  def index_for_owner
    @chats = @shop.chats
  end

  # オーナー側から見た各ユーザーとの個別チャット
  def show_for_owner
    @user = User.find_by(public_uid: params[:user_id])
    @chat = Chat.find_by(shop_id: params[:id], user_id: @user.id) || Chat.create(shop_id: params[:id], user_id: @user.id)
    @messages = Message.where(chat_id: @chat.id)
  end

  # ユーザーからのメッセージ送信
  def message
    @user = User.find(session[:user_id])
    @chat = Chat.find_by(shop_id: @shop.id, user_id: @user.id) || Chat.create(shop_id: @shop.id, user_id: @user.id)
    # current_userがuser_idかowner_idどちらに合うか    
    @messages = @chat.messages
    @message = @chat.messages.build(content: params[:content], sender: @user.name)
    respond_to do |format|
      if @message.save
        format.html { redirect_to ch_show_path(params[:id]) }
        format.js
      else
        format.html { render :show }
        format.js { render :errors }
      end
    end
  end

  # ショップ側からのメッセージ送信
  def message_from_shop
    @user = User.find_by(public_uid: params[:user])
    @chat = Chat.find_by(shop_id: @shop.id, user_id: @user.id) || Chat.create(shop_id: @shop.id, user_id: @user.id)
    @messages = @chat.messages
    @message = @chat.messages.build(content: params[:content], sender: @shop.name)
    respond_to do |format|
      if @message.save
        format.html { redirect_to ch_show_owner_path(params[:id]) }
        format.js
      else
        format.html { render :show_for_owner }
        format.js { render :errors }
      end
    end
  end
  
  private
    def set_shop
      @shop = Shop.find(params[:id])
    end

    def set_chat
      @chat = Chat.find_by(shop_id: params[:id], user_id: session[:user_id])
    end

    def set_current_user
      if session[:user_id]
        @current_user = User.find(session[:user_id])
      else
        session[:owner_id]
        @current_user = Owner.find(session[:owner_id])
      end
    end
end
