class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "User #{current_user.name} subscribed to AppearanceChannel"
    current_user.update(online: true) if current_user
    stream_from "appearance_channel"
  end

  def unsubscribed
    Rails.logger.info "User #{current_user.name} unsubscribed from AppearanceChannel"
    current_user.update(online: false) if current_user
  end
end
