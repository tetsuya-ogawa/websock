class RoomsController < ApplicationController

  before_action :set_room, only: [:edit, :update, :show, :destroy]

  def index
     @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new
    @room.assign_attributes(room_params)
    if @room.save
      flash[:notice] = '部屋を作成しました'
      redirect_to room_path(@room)
    else
      flash[:alert] = '部屋を作成できませんでした'
      render :new
    end

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

  def room_params
    params.require(:room).permit(:name)
  end

end
