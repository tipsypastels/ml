class AddAdminToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :admin, :boolean, default: false
  end
end
