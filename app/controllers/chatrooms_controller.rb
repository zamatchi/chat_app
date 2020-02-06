class ChatroomsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_chatroom, only: [:show]
    
  def index
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

  def show
    @posts = Post.where(chatroom_id: params[:id])
    @questions = Question.where(chatroom_id: params[:id]).limit(20).order('id DESC')
  end

  def edit
  end

  def update
    
    if @chatroom.update(chatroom_params)
      flash[:success] = "編集しました"
      redirect_to @chatroom
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @chatroom.destroy
    
    flash[:success] = 'ルームは削除されました'
    redirect_to root_url
  end
  
  private
  
  def chatroom_params
    params.require(:chatroom).permit(:name, :genre, :target, :comment)
  end
  
  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end
  
  def correct_user
    @chatroom = current_user.chatrooms.find_by(id: params[:id])
    unless @chatroom
      redirect_to root_path
    end
  end
end
