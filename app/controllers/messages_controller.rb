# class MessagesController < ApplicationController

#   def new

#   end

#   def create
#     @chat = Chat.find_by(shop_id: params[:id], user_id: session[:user_id]) || Chat.create(shop_id: params[:id], user_id: session[:user_id])
#     @messages = @chat.messages
#     @message = @chat.messages.build(content: params[:message][:content])
#     respond_to do |format|
#       if @message.save
#         format.html { redirect_to ch_show_path(params[:id]) }
#         format.js
#       else
#         format.html { render :new }
#         format.js { render :errors }
#       end
#     end
#   end

#   def destroy

#   end

#   private

#     def set_shop
#       @shop = Shop.find(params[:id])
#     end

#     def message_params
#       params.permit(:content)
#     end
# end
