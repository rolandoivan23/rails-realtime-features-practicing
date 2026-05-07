class AddConnectionCountToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :connection_count, :integer, default: 0
  end
end
