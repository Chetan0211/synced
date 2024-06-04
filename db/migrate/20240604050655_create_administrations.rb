class CreateAdministrations < ActiveRecord::Migration[7.1]
  def change
    create_table :administrations, id: :uuid do |t|

      t.string :name, null: false
      t.string :email, null: false
      t.string :email_identifier, null: false

      t.timestamps
    end
  end
end
