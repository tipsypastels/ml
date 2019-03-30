class TopicsCountDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :topics_count, 0
  end
end
