class AddStatusToAdministration < ActiveRecord::Migration[7.1]
  def change
    add_column :administrations, :status, :integer, default: 0, null: false
    add_index :administrations, :status
  end
end
