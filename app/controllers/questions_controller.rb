class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_question, only: [:show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @questions = Question.where(chatroom_id: params[:chatroom_id]).order('id DESC').page(params[:page]).per(25)
    @chatroom = Chatroom.find(params[:chatroom_id])
  end
  
  def show
    @chatroom = @question.chatroom
    @user = @question.user
    @answers = Answer.where(question_id: params[:id])
    @bestanswer_num =  @question.bestanswer
    @bestanswer = Answer.find_by(id: @bestanswer_num)
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
    @chatroom = @question.chatroom
  end
  
  def update
    if @question.update(question_params)
      flash[:success] = "更新しました。"
      redirect_to @question
    else
      flash.now[:danger] = "更新に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @chatroom = @question.chatroom
    
    @question.destroy
    
    flash[:success] = "質問を削除しました。"
    redirect_to @chatroom
  end
  
  
  private
  
  def question_params
    params.require(:question).permit(:title, :detail, :bestanswer, :user_id, :chatroom_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
  
  def correct_user
    @question = current_user.questions.find_by(id: params[:id])
    unless @question
      redirect_to root_path
    end
  end
end