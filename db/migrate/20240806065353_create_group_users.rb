class CreateGroupUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :group_users, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :group_id, null: false
      t.uuid :user_id, null: false

      t.timestamps
    end
    add_foreign_key :group_users, :groups, column: :group_id
    add_foreign_key :group_users, :users, column: :user_id
    add_index :group_users, :group_id
    add_index :group_users, :user_id
  end
end
