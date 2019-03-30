class AddTopicsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :topics_count, :integer
  end
end
