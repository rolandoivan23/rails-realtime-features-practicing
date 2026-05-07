module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if verified_user = User.find_by(id: cookies.encrypted[:user_id])
        Rails.logger.info "ActionCable connected for user: #{verified_user.name}"
        verified_user
      else
        Rails.logger.error "ActionCable connection rejected: User not found from cookie"
        reject_unauthorized_connection
      end
    end
  end
end
