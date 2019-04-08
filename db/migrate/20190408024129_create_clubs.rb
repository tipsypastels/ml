class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :title
      t.text :description
      t.integer :visibility
      t.string :slug

      t.timestamps
    end
  end
end
