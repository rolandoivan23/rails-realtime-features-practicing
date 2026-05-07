class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    current_user.appear if current_user
    stream_from "appearance_channel"
  end

  def unsubscribed
    current_user.disappear if current_user
  end
end
