class AnswersController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_answer_question, only: [:edit, :update, :destroy]
  def new
    @question = Question.find(params[:question_id])
    @user = @question.user
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @question = Question.find(params[:question_id])
    # @question = Question.find(params[:answer][:question_id])
    @user = @question.user

    if @answer.save
      flash[:success] = "回答ありがとうございます。"
      redirect_to @question
    else
      flash.now[:danger] = "回答に失敗しました。"
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
    @answer = @question.answers.find(params[:question_id])
    
    @user = @question.user
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])

    if @answer.update(answer_params)
      flash[:success] = "回答を更新しました。"
      redirect_to @question
    else
      flash.now[:danger] = "回答の更新に失敗しました。"
      render :edit
    end
  end
  

  def destroy
    # binding.pry
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @answer.destroy
    
    flash[:success] = "回答を削除しました。"
    redirect_to @question
  end
  
  private
  
  def answer_params
    params.require(:answer).permit(:answer, :user_id, :question_id)
  end
  
  def set_answer_question
    # binding.pry
  
    # @question = Question.find(params[:question_id])
    # @answer = @question.answers.find(params[:question_id])
    # @user = @question.user
    # @answer = Answer.find(params[:id])
    # @question = @answer.question
  end
end