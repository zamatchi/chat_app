# サーバーサイドの処理を受け持つチャンネル
class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_channel"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Post.create! content: data['message']
    templete = ApplicationController.renderer.render(partial: 'posts/post', locals: { post: message })
    ActionCable.server.broadcast 'chatroom_channel', message: templete
  end
end