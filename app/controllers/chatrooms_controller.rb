class ChatroomsController < ApplicationController
  
  
  def index
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    puts "==============================================================================="
    puts @chatroom
    puts "==============================================================================="
    @posts = Post.where(chatroom_id: params[:id])
  end

  def edit
    @chatroom = Chatroom.find(params[:id])
  end

  def update
  end
  
  def new
    @chatroom = current_user.chatrooms.build
  end

  def create
    @chatroom = current_user.chatrooms.build(chatroom_params)
    
    if @chatroom.save
      flash[:success] = "ルーム作成完了"
      redirect_to @chatroom
    else
      flash.now[:danger] = "ルーム作成失敗"
      render :new
    end
  end

  def destroy
  end
  
  def users
    @chatroom = Chatroom.find(params[:id])
    @joinings = @chatroom.spoken_user
  end
  
  private
  
  def chatroom_params
    params.require(:chatroom).permit(:name, :genre, :target, :comment)
  end
end
