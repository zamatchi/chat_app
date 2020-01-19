# クライアントサイドの処理を受け持つチャンネ
App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#posts').append data['message']
    
    
    # Called when there's incoming data on the websocket for this channel

  speak: (content) ->
    @perform 'speak', message: content


document.addEventListener 'DOMContentLoaded', ->
  input = document.getElementById('chat_input')
  button = document.getElementById('chat_button')
  button.addEventListener 'click', ->
    content = input.value
    App.chatroom.speak(content)
    input.value = ''
    return
  return