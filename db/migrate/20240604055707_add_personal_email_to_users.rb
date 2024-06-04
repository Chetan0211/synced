class AddPersonalEmailToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :personal_email, :string
    add_index :users, :personal_email
  end
end
