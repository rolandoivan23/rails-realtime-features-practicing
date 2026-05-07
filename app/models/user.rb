class User < ApplicationRecord
  has_secure_password
  has_many :messages, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true

  # Broadcast to the "users" stream when a user's status changes
  after_update_commit -> {
    broadcast_replace_to "users",
                         target: "users",
                         partial: "users/users",
                         locals: { users: User.where(online: true) }
  }
end
