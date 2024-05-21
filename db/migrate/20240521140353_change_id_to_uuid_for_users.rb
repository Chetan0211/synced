class ChangeIdToUuidForUsers < ActiveRecord::Migration[7.1]
  def change
    # Add a new UUID column
    add_column :users, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    # Update the primary key
    remove_column :users, :id
    rename_column :users, :uuid, :id
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end
