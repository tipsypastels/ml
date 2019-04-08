class TopicPermissions < ApplicationPermissions
  attr_reader :topic

  def initialize(topic, user)
    @topic = topic
    @user  = user # User | nil
  end

  def post_permissions
    if !can_view?
      :cant_view
    elsif no_user?
      :logged_out
    elsif user.banned?
      :banned
    elsif topic.locked?
      if can_admin?
        :locked_but_admin
      elsif can_moderate?
        :locked_but_club_moderator
      else
        :locked
      end
    elsif topic.club?
      if in_club?
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

  CAN_POST_PERMISSIONS = %i|
    open
    club_member
    locked_but_club_moderator
    locked_but_admin
    not_club_member_but_admin
  |

  def can_post?
    CAN_POST_PERMISSIONS.include?(post_permissions)
  end

  def view_permissions
    if private_club?
      if no_user?
        :logged_out_in_private_club
      elsif in_club?
        :club_member
      elsif can_admin?
        :not_club_member_but_admin
      else
        :not_club_member
      end
    else
      :visible
    end
  end

  CAN_VIEW_PERMISSIONS = %i|
    visible
    club_member
    not_club_member_but_admin
  |

  def can_view?
    CAN_VIEW_PERMISSIONS.include?(view_permissions)
  end

  def in_club?
    user.club?(topic.club)
  end

  def private_club?
    topic.private_club?
  end
end