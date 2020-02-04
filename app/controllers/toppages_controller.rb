class ToppagesController < ApplicationController
  def index
    @setting = ActiveSupport::OrderedOptions.new
    @setting.name = params[:name]
    @chatrooms = Chatroom.search(params[:name]).page(params[:page]).per(15)
  end
end
