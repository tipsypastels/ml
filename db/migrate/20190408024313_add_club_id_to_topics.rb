class AddClubIdToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :club_id, :integer
  end
end
