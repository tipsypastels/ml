class CreatePermissions < ApplicationPermissions
  # creating topic, club, etc
  def create_permissions
    if no_user?
      :logged_out
    elsif user.banned?
      :banned
    else
      true
    end
  end

  def can_create?
    create_permissions == true
  end
end