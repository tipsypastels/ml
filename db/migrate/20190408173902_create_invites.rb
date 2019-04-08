class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.integer :club_id
      t.integer :user_id
      t.integer :uses
      t.string :hex

      t.timestamps
    end
  end
end
