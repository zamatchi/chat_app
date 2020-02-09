class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show]
  def show
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "登録完了しました"
      redirect_to root_path
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "更新しました"
      redirect_to @user
    else
      flash.now[:danger] = "更新に失敗しました"
      render :edit
    end
  end
  
  # def favorites
  def myrooms
    @user = User.find(params[:id])
    @favorites = @user.favoritings.page(params[:page]).per(15)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_path
    end
  end
end
