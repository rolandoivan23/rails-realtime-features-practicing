# Reset all users to offline on boot
Rails.application.config.after_initialize do
  User.update_all(online: false) if ActiveRecord::Base.connection.table_exists?('users')
rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid
  # Skip if database/table doesn't exist yet (e.g. during migrations)
end
