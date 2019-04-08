class AddOwnerIdToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :owner_id, :integer
  end
end
