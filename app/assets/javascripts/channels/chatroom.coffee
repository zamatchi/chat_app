# クライアントサイドの処理を受け持つチャンネ
App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # alert data['message']
    $('#posts').append data['message']
    
    
    # Called when there's incoming data on the websocket for this channel

  speak: (content, data_user, data_room) ->
    @perform 'speak', message: content, user_id: data_user, room_id: data_room
    

# document.addEventListener 'DOMContentLoaded', ->
document.addEventListener 'turbolinks:load', ->
  input = document.getElementById('chat_input')
  if input?
    data_user = input.getAttribute("data_user")
    data_room = input.getAttribute("data_room")
    button = document.getElementById('chat_button')
    button.addEventListener 'click', ->
      content = input.value
      App.chatroom.speak(content, data_user, data_room)
      input.value = ''
      return
    return