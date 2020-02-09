class UserChatroomsController < ApplicationController
  def create
    chatroom = Chatroom.find(params[:user_chatroom][:chatroom_id])
    current_user.favorite(chatroom)
    flash[:success] = "マイルームに追加しました。"
    redirect_to chatroom
  end

  def destroy
    chatroom = Chatroom.find(params[:user_chatroom][:chatroom_id])
    current_user.unfavorite(chatroom)
    flash[:success] = "マイルームから解除しました。"
    redirect_to chatroom
  end
  
  private
end
