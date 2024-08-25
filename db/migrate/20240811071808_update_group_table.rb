class UpdateGroupTable < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :multiple_users, :boolean, default: false
  end
end
