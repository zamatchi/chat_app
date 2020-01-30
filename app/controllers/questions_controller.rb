class QuestionsController < ApplicationController
  # before_action :register_user_chatroom_id, only: [:create]
  def index
    @questions = Question.all
  end
  
  def show
    @question = Question.find(params[:id])
    @user = @question.user
  end

  def new
    @question = Question.new
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def create
    @chatroom = Chatroom.find(params[:question][:chatroom_id])
    @question = Question.new(question_params)
    
    if @question.save
      flash[:success] = "質問を投稿しました。"
      redirect_to chatroom_path(@chatroom)
    else
      flash.now[:danger] = "投稿に失敗しました。"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def delete
  end
  
  
  private
  
  def question_params
    params.require(:question).permit(:title, :detail, :user_id, :chatroom_id)
  end
  
  def register_user_chatroom_id
    @chatroom = Chatroom.find(params[:chatroom_id])
    params[:chatroom_id] = @chatroom.id
    params[:user_id] = current_user.id
  end
end
