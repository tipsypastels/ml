class AddStuffToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :location, :string
    add_column :users, :gender, :integer
    add_column :users, :relationship_status, :integer
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
  end
end
