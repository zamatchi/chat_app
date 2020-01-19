class PostsController < ApplicationController
  before_action :register_chatroom_id, only: [:new]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    
    if @post.save
      redirect_to @chatroom
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content)
  end
  
  def register_chatroom_id
    @chatroom = Chatroom.find(params[:id])
    params[:chatroom_id] = @chatroom.id
  end
end
