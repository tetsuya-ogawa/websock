class RoomChannel < ApplicationCable::Channel
  def subscribed
    #stream_from "room_channel#{params['room_id']}"
    @room = Room.find(params['room_id'])
    stream_for @room
  end

  def unsubscribed

  end

  def speak(data)
    @room = Room.find(data['room_id'])
    Message.create(content: data['message'], room_id: data['room_id'], user: current_user)
    #ActionCable.server.broadcast "room_channel#{data['room_id']}", message: data['message']
    RoomChannel.broadcast_to(@room, message: data['message'])
  end
end
