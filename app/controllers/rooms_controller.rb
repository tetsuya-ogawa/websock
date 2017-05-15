class RoomsController < ApplicationController

  before_action :set_room, only: [:edit, :update, :show, :destroy]

  def index
     @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def show
    @messages = @room.messages
  end

  def destroy

  end

  private

  def set_room
    @room = Room.includes(:messages).find(params[:id])
  end

end
