class UniqueHex < ActiveRecord::Migration[5.2]
  def change
    add_index :invites, :hex, unique: true
  end
end
