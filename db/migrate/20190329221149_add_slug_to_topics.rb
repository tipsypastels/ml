class AddSlugToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :slug, :string
    add_index :topics, :slug, unique: true
  end
end
