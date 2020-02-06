class ToppagesController < ApplicationController
  def index
    @setting = ActiveSupport::OrderedOptions.new
    @setting.name = params[:name]
    @setting.genre = params[:genre]
    @setting.target = params[:target]
    genre = Chatroom.genres[params[:genre]]
    target = Chatroom.targets[params[:target]]
    @chatrooms = Chatroom.search(params[:name], genre, target).page(params[:page]).per(15)
  end
end