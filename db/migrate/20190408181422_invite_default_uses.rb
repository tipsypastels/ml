class InviteDefaultUses < ActiveRecord::Migration[5.2]
  def change
    change_column_default :invites, :uses, 0
  end
end
