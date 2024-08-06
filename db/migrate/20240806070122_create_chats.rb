class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :from_id, null: false
      t.uuid :to_group_id, null: false
      t.text :message, null: false
      t.uuid :administration_id, null: false

      t.timestamps
    end
    add_foreign_key :chats, :users, column: :from_id
    add_foreign_key :chats, :groups, column: :to_group_id
    add_foreign_key :chats, :administrations, column: :administration_id
    add_index :chats, :from_id
    add_index :chats, :to_group_id
    add_index :chats, :administration_id
  end
end
