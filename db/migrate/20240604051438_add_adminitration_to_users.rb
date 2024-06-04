class AddAdminitrationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :administration_id, :uuid
    add_foreign_key :users, :administrations, column: :administration_id
    add_index :users, :administration_id
  end
end
