class UpdateChatting < ActiveRecord::Migration[7.1]
  def change
    add_column :group_users, :last_chat_seen_id, :uuid
    add_foreign_key :group_users, :chats, column: :last_chat_seen_id
    add_index :group_users, :last_chat_seen_id

    change_column_null :groups, :name, false
    change_column_null :groups, :administration_id, false
  end
end
