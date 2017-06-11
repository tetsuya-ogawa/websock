class Rooms::UsersController < ApplicationController

  before_action :set_room

  def create
    redirect_to root_path
  end

  def destroy

  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def users_params
    params.require(:room).permit(:name)
  end

end
