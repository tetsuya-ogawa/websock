App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $(location)[0].pathname.split('/')[2] },
  connected: ->

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').append "
    <li class='message'>
      <div class='message-user'>
        name
      </div>
      <div class='message-content'>
        #{data['message']}
      </div>
    </li>
    "

  speak:(message, room_id)->
    @perform 'speak', {message: message, room_id: room_id}


$(document).on 'keypress', '[data-behavior~=room_input]', (event) ->
  if event.keyCode == 13
    if event.shiftKey
      $.noop()
    else
      App.room.speak event.target.value, $(location)[0].pathname.split('/')[2]
      event.target.value = ''
      event.preventDefault()
