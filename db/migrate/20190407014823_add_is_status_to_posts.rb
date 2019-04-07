class AddIsStatusToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_status, :boolean, default: false
  end
end
