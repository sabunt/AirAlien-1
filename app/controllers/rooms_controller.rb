class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @rooms = current_user.rooms
  end

  def show
    @photos = @room.photos
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new(room_params)

    if @room.save
      if params[:images]
        params[:images].each do |image|
          @room.photos.create(image: image)
        end
      end

      @photos = @room.photos
      redirect_to edit_room_path(@room), notice: "Room created!"
    else
      render :new, alert: "Room could not be created!"
    end
  end

  def edit
    if current_user.id == @room.user.id
      @photos = @room.photos
    else
      redirect_to root_path, notice: "You cannot do this!"
    end
  end

  def update
    if @room.update(room_params)
      if params[:images]
        params[:images].each do |image|
          @room.photos.create(image: image)
        end
      end
      
      # @photos = @room.photos // testing to see if I don't need this?
      redirect_to edit_room_path(@room), notice: "Room updated!!"
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
