class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name
      t.uuid :administration_id
      t.timestamps
    end
    add_foreign_key :groups, :administrations, column: :administration_id
    add_index :groups, :administration_id
  end
end
