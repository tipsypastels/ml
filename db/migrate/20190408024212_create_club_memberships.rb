class CreateClubMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :club_memberships do |t|
      t.integer :user_id
      t.integer :club_id
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
