class ClubPermissions < ApplicationPermissions
  attr_reader :club

  def initialize(club, user)
    @club = club
    @user = user
  end

  def view_permissions
    if private_club?
      if no_user?
        :logged_out
      elsif club_member?
        :club_member
      elsif can_admin?
        :not_club_member_but_admin
      else
        :not_club_member
      end
    else
      :open
    end
  end

  CAN_VIEW_PERMISSIONS = %i|
    open
    club_member
    not_club_member_but_admin
  |

  def can_view?
    CAN_VIEW_PERMISSIONS.include?(view_permissions)
  end

  def create_permissions
    if club_member?
      :club_member
    elsif can_admin?
      :not_club_member_but_admin
    else
      :not_club_member
    end
  end

  CAN_CREATE_PERMISSIONS = %i|
    club_member
    not_club_member_but_admin
  |

  def can_create_in?
    CAN_CREATE_PERMISSIONS.include?(create_permissions)
  end

  def join_permissions
    if no_user?
      :logged_out
    elsif club_member?
      :already_member
    elsif private_club?
      :private
    else
      true
    end
  end

  def can_join?
    join_permissions == true
  end

  def can_invite?
    if private_club?
      club_moderator?
    else
      user.club?(club)
    end
  end

  def club_member?
    user && user.club?(club)
  end

  def club_moderator?
    user && user.moderates?(club)
  end

  def private_club?
    club.vis_private?
  end
end