class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @rooms = current_user.rooms
  end

  def show
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.room.new(room_params)

    if @room.save
      redirect_to @room, notice: "Room created!"
    else
      render :new, alert: "Room could not be created!"
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: "Room info updated!"
    else
      render :edit, alert: "Room could not be updated!"
    end
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:home_type, :room_type, :accomodate, :bedroom, :bathroom, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_ac, :is_heating, :is_internet, :price, :active)
    end
end
