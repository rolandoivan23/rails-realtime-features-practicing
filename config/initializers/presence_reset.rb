# Reset all users to offline on boot
User.update_all(online: false) if ActiveRecord::Base.connection.table_exists?('users')
