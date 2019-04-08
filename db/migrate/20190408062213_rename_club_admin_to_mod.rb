class RenameClubAdminToMod < ActiveRecord::Migration[5.2]
  def change
    rename_column :club_memberships, :admin, :moderator
  end
end
