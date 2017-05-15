App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $(location)[0].pathname.split('/')[2] },
  connected: ->

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').append "<li class='message'>#{data['message']}</li>"

  speak:(message, room_id)->
    @perform 'speak', {message: message, room_id: room_id}


$(document).on 'keypress', '[data-behavior~=room_input]', (event) ->
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value, $(location)[0].pathname.split('/')[2]
    event.target.value = ''
    event.preventDefault()