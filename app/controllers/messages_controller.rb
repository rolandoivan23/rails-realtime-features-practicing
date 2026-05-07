class MessagesController < ApplicationController
  before_action :set_room

  def create
    @message = @room.messages.new(message_params)
    @message.user = current_user

    if @message.save
      # No need for redirect_to or explicit turbo_stream response here if we rely on
      # model-level broadcasts for the update, but we usually want to clear the input.
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @room }
      end
    else
      render "rooms/show", status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
