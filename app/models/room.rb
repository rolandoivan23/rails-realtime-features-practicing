class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  # Broadcast to the "rooms" stream when a room is created
  after_create_commit -> { broadcast_append_to "rooms", target: "rooms", partial: "rooms/room", locals: { room: self } }
end
