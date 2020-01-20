# クライアントサイドの処理を受け持つチャンネ
App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#posts').append data['message']
    
    
    # Called when there's incoming data on the websocket for this channel

  speak: (content, data_user, data_room) ->
    @perform 'speak', message: content, user_id: data_user, room_id: data_room


document.addEventListener 'DOMContentLoaded', ->
  input = document.getElementById('chat_input')
  data_user = document.getElementsByTagName("input")[0].getAttribute("data_user")
  data_room = document.getElementsByTagName("input")[0].getAttribute("data_room")
  button = document.getElementById('chat_button')
  button.addEventListener 'click', ->
    content = input.value
    App.chatroom.speak(content, data_user, data_room)
    input.value = ''
    return
  return