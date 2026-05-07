class User < ApplicationRecord
  has_secure_password
  has_many :messages, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true

  def appear
    Rails.logger.info "APPEAR: User #{name} is appearing. Current count: #{connection_count}"
    update(online: true, connection_count: connection_count + 1)
  end

  def disappear
    Rails.logger.info "DISAPPEAR: User #{name} is disappearing. Current count: #{connection_count}"
    new_count = [connection_count - 1, 0].max
    update(online: new_count > 0, connection_count: new_count)
  end

  # Broadcast to the "users" stream when a user's status changes
  after_update_commit -> {
    if saved_change_to_online?
      if online?
        broadcast_append_to "users",
                            target: "online_users",
                            partial: "users/user_status",
                            locals: { user: self }
      else
        broadcast_remove_to "users",
                            target: ActionView::RecordIdentifier.dom_id(self, :online)
      end
    end
  }
end
