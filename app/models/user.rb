class User < ApplicationRecord
  has_secure_password
  has_many :messages, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true

  def appear
    update(online: true, connection_count: connection_count + 1)
  end

  def disappear
    new_count = [connection_count - 1, 0].max
    update(online: new_count > 0, connection_count: new_count)
  end

  # Broadcast to the "users" stream when a user's status changes
  after_update_commit -> {
    if saved_change_to_online?
      broadcast_replace_to "users",
                           target: "users",
                           partial: "users/users",
                           locals: { users: User.where(online: true) }
    end
  }
end
