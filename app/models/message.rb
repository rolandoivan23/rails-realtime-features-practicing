class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :content, presence: true

  # This line is the "Rails Way" to trigger Action Cable broadcasts automatically.
  # It will broadcast to a stream named after the room.
  broadcasts_to :room
end
