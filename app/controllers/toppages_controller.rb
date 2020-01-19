class ToppagesController < ApplicationController
  def index
    if logged_in?
      @chatroom = Chatroom.new
      @chatrooms = Chatroom.all
    end
  end
end
