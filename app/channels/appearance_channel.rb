class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    current_user.update(online: true) if current_user
    stream_from "appearance_channel"
  end

  def unsubscribed
    current_user.update(online: true) if current_user # Fallback if we want to keep it simple, but let's actually set false
    current_user.update(online: false) if current_user
  end
end
