class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @new_room = Room.new
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @new_message = Message.new(room: @room)
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @room, notice: "Room was successfully created." }
      end
    else
      @rooms = Room.all
      @new_room = @room
      render :index, status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
