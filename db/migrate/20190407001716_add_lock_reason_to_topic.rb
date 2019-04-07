class AddLockReasonToTopic < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :lock_reason, :string
  end
end
